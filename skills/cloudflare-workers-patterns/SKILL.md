---
name: cloudflare-workers-patterns
description: "Cloudflare Workers + KV 패턴. ES module fetch 핸들러, KV 저장·리더보드, wrangler/대시보드 시크릿(키 하드코딩 금지), LLM API 프록시(브라우저 키 숨기기), CORS·Origin 확인·rate limit, 라우팅. Worker로 API·프록시·엣지 저장을 만들 때 사용."
origin: custom
---

# Cloudflare Workers + KV 패턴

엣지에서 도는 서버리스 함수(Workers)와 키-값 저장(KV)으로 API·프록시·간단한 상태 저장을 만드는 패턴.

## 1. 기본 구조 (ES modules)

```js
export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    if (url.pathname === "/api/gemini" && request.method === "POST") {
      return handleGemini(request, env, ctx);
    }
    if (url.pathname === "/api/score") return handleScore(request, env);
    return new Response("Not found", { status: 404 });
  },
};
```

- `env` = 바인딩(시크릿·KV·변수) 접근 객체. **전역이 아니라 항상 `env`로** 받는다.
- `ctx.waitUntil(p)` = 응답 후에도 끝내야 할 비동기 작업(로그·집계)을 백그라운드로.
- 구형 `addEventListener("fetch", ...)`(Service Worker 문법) 대신 위 **module 문법**을 쓴다.

### wrangler.toml

```toml
name = "cjpdedu"
main = "src/worker.js"
compatibility_date = "2024-09-01"

[[kv_namespaces]]
binding = "SCORES"          # 코드에서 env.SCORES
id = "xxxxxxxxxxxx"
```

## 2. 시크릿 — 절대 하드코딩 금지

API 키는 코드·`wrangler.toml`·git에 두지 않는다. **시크릿으로만**:

```bash
wrangler secret put GEMINI_API_KEY     # 프롬프트로 값 입력, 대시보드에도 표시 안 됨
```

코드에서 `env.GEMINI_API_KEY`로 접근. 대시보드 편집기로 배포하는 경우 Settings → Variables → **Encrypt**로 등록.

- 공개 상수(모델 목록 등)는 `[vars]`(평문)로, 비밀은 secret으로 분리.
- git에는 `wrangler.toml`만, 실제 값은 절대 커밋하지 않는다.

## 3. LLM API 프록시 — 브라우저 키 숨기기 (핵심 패턴)

브라우저가 `/api/gemini`(같은 도메인)로 보내면 Worker가 **시크릿 키를 붙여** 업스트림에 중계한다. 키는 브라우저에 노출되지 않는다. (Gemini 요청/응답 구조는 `gemini-api` 스킬 참고.)

```js
const ALLOWED_ORIGINS = ["https://cjpdedu.md1hrd6390.workers.dev"];

async function handleGemini(request, env, ctx) {
  // (a) Origin 확인 — 아무 사이트나 이 프록시를 못 쓰게
  const origin = request.headers.get("Origin") || "";
  if (!ALLOWED_ORIGINS.includes(origin)) return new Response("Forbidden", { status: 403 });

  // (b) rate limit — IP 기준 분당 호출 제한 (KV)
  const ip = request.headers.get("CF-Connecting-IP") || "unknown";
  const rlKey = `rl:${ip}:${Math.floor(Date.now() / 60000)}`;
  const n = parseInt((await env.RL.get(rlKey)) || "0", 10);
  if (n >= 30) return new Response("Too Many Requests", { status: 429 });
  ctx.waitUntil(env.RL.put(rlKey, String(n + 1), { expirationTtl: 120 }));

  // (c) 업스트림 호출 — 키는 시크릿에서
  const body = await request.text();                 // 필요하면 스키마 검증
  const model = "gemini-flash-latest";               // 또는 폴백 로직
  const upstream = await fetch(
    `https://generativelanguage.googleapis.com/v1beta/models/${model}:streamGenerateContent?alt=sse`,
    { method: "POST",
      headers: { "x-goog-api-key": env.GEMINI_API_KEY, "Content-Type": "application/json" },
      body });

  // (d) 스트림을 그대로 브라우저로 흘려보냄 + CORS
  return new Response(upstream.body, {
    status: upstream.status,
    headers: {
      "Content-Type": "text/event-stream",
      "Access-Control-Allow-Origin": origin,
    },
  });
}
```

이 한 패턴이 "브라우저에 박힌 키" 문제를 해결한다: **키 제거 → 같은 도메인 상대경로 호출 → Origin·rate limit → 기존 키 폐기·재발급**.

## 4. CORS 프리플라이트

브라우저가 `POST`(+커스텀 헤더) 전에 `OPTIONS`를 보낸다. 처리 안 하면 호출이 막힌다.

```js
if (request.method === "OPTIONS") {
  return new Response(null, { status: 204, headers: {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type",
    "Access-Control-Max-Age": "86400",
  }});
}
```

같은 도메인에서 서빙하면 CORS 자체가 필요 없다 — 가능하면 앱과 API를 **같은 Worker/도메인**에 둔다.

## 5. KV 저장 — 점수·리더보드 패턴

KV는 **읽기 많고 쓰기 적은** 키-값 저장. 사번 기준 점수 저장·리더보드에 적합.

```js
async function handleScore(request, env) {
  if (request.method === "POST") {
    const { empId, score } = await request.json();
    if (!/^\d{4,10}$/.test(String(empId))) return json({ error: "bad empId" }, 400);
    const prev = parseInt((await env.SCORES.get(`s:${empId}`)) || "0", 10);
    if (score > prev) await env.SCORES.put(`s:${empId}`, String(score)); // 최고점만
    return json({ ok: true });
  }
  // 리더보드 (상위 N)
  const list = await env.SCORES.list({ prefix: "s:" });
  const rows = await Promise.all(list.keys.map(async k => ({
    empId: k.name.slice(2), score: parseInt((await env.SCORES.get(k.name)) || "0", 10),
  })));
  rows.sort((a, b) => b.score - a.score);
  return json(rows.slice(0, 20));
}
const json = (o, status = 200) =>
  new Response(JSON.stringify(o), { status, headers: { "Content-Type": "application/json" } });
```

KV 특성·주의:
- **쓰기는 최종 일관성**(전 지역 반영에 지연 가능) — 실시간 카운터·원자적 증감엔 부적합. 그런 용도는 **Durable Objects**를 고려.
- 값은 문자열(또는 바이너리) — 객체는 `JSON.stringify`.
- `list()`는 최대 1000개/페이지(`cursor`로 페이지네이션). 대규모 정렬 리더보드는 KV만으론 한계 → 상위 점수를 별도 키에 집계하거나 D1(SQL) 고려.
- `expirationTtl`로 만료 지정(rate-limit 카운터·세션 등).

## 6. 저장·컴퓨트 선택 가이드

| 필요 | 선택 |
|---|---|
| 읽기 많은 키-값(설정·점수·캐시) | **KV** |
| 원자적 카운터·실시간 조율·세션 | **Durable Objects** |
| 관계형 쿼리·정렬·집계 | **D1**(SQLite) |
| 큰 파일·이미지 | **R2** |

## 7. 배포·운영

- 배포: `wrangler deploy` (또는 대시보드 편집기 붙여넣기 → Deploy).
- 로컬: `wrangler dev`로 엣지 런타임 로컬 실행, `wrangler tail`로 실시간 로그.
- 시크릿·KV 바인딩은 **배포 환경마다** 등록돼 있어야 한다(로컬엔 있는데 프로덕션엔 없어 500 나는 실수 잦음).
- 무료 플랜 한도(요청 수·CPU 시간·KV 읽기/쓰기)를 넘기면 429/과금 — rate limit과 캐싱으로 방어.
