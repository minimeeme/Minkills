---
name: gemini-api
description: "Google Gemini(generativelanguage) REST API 연동 패턴. 멀티 모델 폴백, SSE 스트리밍, contents/systemInstruction/generationConfig 요청 구조, 에러·rate limit·quota 처리, 그리고 브라우저에 API 키를 노출하지 않는 서버/프록시 패턴. Gemini로 챗봇·텍스트 생성을 붙이거나 브라우저 직접 호출을 서버 뒤로 숨길 때 사용."
origin: custom
---

# Gemini API 연동 패턴

Google Gemini(`generativelanguage.googleapis.com`) REST API를 안전하고 견고하게 붙이기 위한 패턴. 챗봇·해설·요약 등 텍스트 생성에 사용.

## ⚠️ 0. 가장 먼저: 키를 브라우저에 두지 마라

`fetch("...?key=API_KEY")`를 **브라우저(클라이언트) JS에서 직접 호출하면 키가 그대로 노출**된다. 소스 보기·네트워크 탭·번들 파일 어디서든 꺼낼 수 있고, 피해는 **할당량 도용·과금**이다. 데모/파일럿에서만 허용하고, 정식 전환 전 반드시 서버/프록시 뒤로 옮긴다(→ 5장). Cloudflare Workers 프록시는 `cloudflare-workers-patterns` 스킬 참고.

## 1. 엔드포인트

```
POST https://generativelanguage.googleapis.com/v1beta/models/{model}:generateContent
POST https://generativelanguage.googleapis.com/v1beta/models/{model}:streamGenerateContent?alt=sse
```

인증은 **헤더 방식 권장**(URL 쿼리 `?key=`는 로그·리퍼러에 남는다):

```
x-goog-api-key: <API_KEY>
Content-Type: application/json
```

모델 ID는 자주 바뀐다(예: `gemini-2.5-flash`, `gemini-flash-latest`, `gemini-pro-latest`). **코드에 하드코딩하지 말고 설정/환경변수 배열로** 두고, `models.list`로 사용 가능 모델을 확인할 수 있다:

```
GET https://generativelanguage.googleapis.com/v1beta/models   (x-goog-api-key 헤더)
```

## 2. 요청 본문 구조

```json
{
  "systemInstruction": { "parts": [{ "text": "너는 친절한 클래식 해설가다." }] },
  "contents": [
    { "role": "user",  "parts": [{ "text": "1악장 설명해줘" }] },
    { "role": "model", "parts": [{ "text": "…" }] },
    { "role": "user",  "parts": [{ "text": "더 쉽게" }] }
  ],
  "generationConfig": {
    "temperature": 0.7,
    "maxOutputTokens": 1024,
    "topP": 0.95,
    "responseMimeType": "text/plain"
  },
  "safetySettings": [
    { "category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_ONLY_HIGH" }
  ]
}
```

- 대화 히스토리는 `contents` 배열의 `role: user`/`model` 교대. **시스템 지침은 `systemInstruction`** 에 분리(첫 user 메시지에 욱여넣지 말 것).
- 구조화 출력이 필요하면 `generationConfig.responseMimeType: "application/json"` + `responseSchema`.

## 3. 응답 파싱

```json
{
  "candidates": [{
    "content": { "parts": [{ "text": "…" }], "role": "model" },
    "finishReason": "STOP"
  }],
  "usageMetadata": { "promptTokenCount": 30, "candidatesTokenCount": 210, "totalTokenCount": 240 }
}
```

안전하게 뽑기(파트가 비거나 `finishReason`이 `SAFETY`/`MAX_TOKENS`일 수 있음):

```js
const text = data?.candidates?.[0]?.content?.parts?.map(p => p.text).join("") ?? "";
const reason = data?.candidates?.[0]?.finishReason;
if (!text) throw new Error(`빈 응답 (finishReason=${reason})`);
```

`usageMetadata.totalTokenCount`로 호출별 토큰을 집계해 비용을 추적한다(→ `cost-aware-llm-pipeline`).

## 4. 멀티 모델 폴백 (핵심)

특정 모델이 404(폐기)·429(quota)·503(overload)일 때 다음 모델로 넘어간다. **모델 목록은 설정으로**, 한 번의 호출 실패가 서비스 전체 실패가 되지 않게.

```js
const MODELS = ["gemini-flash-latest", "gemini-2.5-flash", "gemini-pro-latest"]; // 설정에서 주입

async function generate(body, { apiKey, signal }) {
  let lastErr;
  for (const model of MODELS) {
    try {
      const res = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent`,
        { method: "POST", signal,
          headers: { "x-goog-api-key": apiKey, "Content-Type": "application/json" },
          body: JSON.stringify(body) });
      if (res.status === 429 || res.status === 503 || res.status === 404) { lastErr = await res.text(); continue; }
      if (!res.ok) throw new Error(`Gemini ${res.status}: ${await res.text()}`);
      return await res.json();
    } catch (e) { lastErr = e; }         // 네트워크 오류도 다음 모델로
  }
  throw new Error(`모든 모델 실패: ${lastErr}`);
}
```

- 재시도 순서는 **싼/빠른 모델 → 고성능 모델**. 429는 해당 모델의 분당 한도이므로 다른 모델·잠깐 backoff가 유효.
- 429에 `Retry-After`가 있으면 존중. 같은 모델 재시도는 지수 backoff 1회 정도로 제한.

## 5. 스트리밍 (SSE)

`:streamGenerateContent?alt=sse`는 `data: {…json…}` 줄을 흘려보낸다. 각 청크의 `candidates[0].content.parts[0].text`를 이어 붙인다.

```js
const res = await fetch(url + ":streamGenerateContent?alt=sse", {
  method: "POST", headers: { "x-goog-api-key": apiKey, "Content-Type": "application/json" },
  body: JSON.stringify(body), signal });

const reader = res.body.getReader();
const dec = new TextDecoder();
let buf = "";
for (;;) {
  const { value, done } = await reader.read();
  if (done) break;
  buf += dec.decode(value, { stream: true });
  const lines = buf.split("\n");
  buf = lines.pop();                       // 미완성 줄 보관
  for (const line of lines) {
    if (!line.startsWith("data:")) continue;
    const chunk = JSON.parse(line.slice(5).trim());
    const t = chunk?.candidates?.[0]?.content?.parts?.[0]?.text;
    if (t) onDelta(t);                      // UI에 즉시 반영
  }
}
```

- 프록시(서버) → 브라우저로 다시 SSE를 흘릴 때는 **업스트림 스트림을 그대로 pipe**하거나 델타만 재전송.
- 사용자가 중단하면 `AbortController.abort()`로 업스트림도 끊어 토큰 낭비를 막는다.

## 6. 에러·한도 대응 요약

| 상태 | 의미 | 대응 |
|---|---|---|
| 400 | 잘못된 요청(스키마·모델명) | 본문·모델 ID 점검. 재시도 금지 |
| 401/403 | 키 무효·권한 | 키 재발급, 프록시 시크릿 확인 |
| 404 | 모델 폐기/오타 | 폴백 다음 모델, `models.list`로 확인 |
| 429 | quota/rate limit | `Retry-After` 존중, 다른 모델·backoff |
| 500/503 | 일시 장애 | 지수 backoff 1~2회, 폴백 |

- `finishReason: "SAFETY"`면 안전 필터 차단 — 사용자에게 부드럽게 안내하고, 필요 시 `safetySettings` 조정.
- 프롬프트에 사용자 입력을 그대로 넣을 때 **프롬프트 인젝션**을 감안해 시스템 지침을 방어적으로.

## 7. 브라우저→서버 프록시로 옮기기 (마이그레이션 체크리스트)

1. 서버/Worker에 `/api/gemini` 핸들러 추가, 키는 **환경 시크릿**에만 보관(코드·빌드 산출물에서 제거).
2. 브라우저 호출부를 **같은 도메인 상대경로**(`/api/gemini`)로 변경 — 키 없이 호출.
3. 프록시에서 **Origin/Referer 확인** + **호출량 제한**(IP·세션 기준)으로 오남용 차단.
4. 빌드 스크립트의 **키 주입 로직 제거**.
5. **이미 노출된 기존 키는 폐기·재발급** — 이전 배포본에 박혀 있으므로 필수.

구현은 `cloudflare-workers-patterns` 스킬의 "LLM API 프록시" 절 참고.
