# Minkills

밍키가 자주 사용하는 스킬들을 모은 나의 클로드 스킬 모음집입니다.

총 **139개** 스킬을 카테고리별로 정리했습니다. 각 스킬은 `skills/<이름>/SKILL.md`에 있으며, Claude Code가 상황에 맞게 자동으로 불러옵니다.

## 설치 / 사용법

**로컬 PC (모든 로컬 세션에서 사용):**
```bash
git clone https://github.com/minimeeme/Minkills.git
cp -r Minkills/skills/* ~/.claude/skills/     # 전역(개인) 스킬
# 또는 특정 프로젝트에만:  cp -r Minkills/skills/* /your/project/.claude/skills/
```

**Claude Code 클라우드(웹)에서 사용:** 로컬 전역설치는 클라우드로 동기화되지 않습니다. 클라우드 세션이 클론하는 **리포의 `.claude/skills/`에 스킬을 커밋**하거나, 세션 시작 시 이 리포를 클론해 복사하는 **SessionStart 훅**을 설정해야 합니다.

Claude Code에서 `/스킬이름` 으로 직접 호출하거나, 각 스킬 설명의 트리거 조건에 맞으면 자동 활성화됩니다.

## 목차

1. [언어 · 프레임워크 패턴 / 테스트](#1) — 52개
2. [엔지니어링 워크플로 · 품질](#2) — 20개
3. [AI · 에이전트 · 자동화](#3) — 27개
4. [리서치 · 콘텐츠 · 비즈니스](#4) — 17개
5. [도메인 특화 (물류 · 무역 · 제조 등)](#5) — 8개
6. [Figma (디자인 ↔ 코드)](#6) — 14개
7. [기타](#기타) — 1개

---

<a id="1"></a>
## 1. 언어 · 프레임워크 패턴 / 테스트

| 스킬 | 설명 |
| --- | --- |
| `coding-standards` | TypeScript·JavaScript·React·Node.js 개발을 위한 범용 코딩 표준·모범 사례·패턴. |
| `python-patterns` | Pythonic 관용구, PEP 8, 타입 힌트 등 견고·효율·유지보수 가능한 Python 앱을 위한 모범 사례. |
| `python-testing` | pytest, TDD, 픽스처, 모킹, 파라미터화, 커버리지 요건을 활용한 Python 테스트 전략. |
| `golang-patterns` | 견고·효율·유지보수 가능한 Go 앱을 위한 관용적 Go 패턴·모범 사례·규칙. |
| `golang-testing` | 테이블 주도 테스트·서브테스트·벤치마크·퍼징·커버리지를 포함한 Go 테스트 패턴. 관용적 Go로 TDD 수행. |
| `rust-patterns` | 안전·고성능 앱을 위한 관용적 Rust 패턴 — 소유권, 에러 처리, 트레잇, 동시성 모범 사례. |
| `rust-testing` | 단위·통합·비동기·속성 기반 테스트, 모킹, 커버리지를 포함한 Rust 테스트 패턴. TDD 방법론. |
| `kotlin-patterns` | 코루틴·널 안전성·DSL 빌더를 활용한 관용적 Kotlin 패턴·모범 사례·규칙. |
| `kotlin-testing` | Kotest·MockK·코루틴 테스트·속성 기반 테스트·Kover 커버리지를 활용한 Kotlin 테스트 패턴. |
| `kotlin-coroutines-flows` | Android/KMP용 Kotlin 코루틴·Flow 패턴 — 구조적 동시성, Flow 연산자, StateFlow, 에러 처리, 테스트. |
| `kotlin-exposed-patterns` | JetBrains Exposed ORM 패턴 — DSL 쿼리, DAO, 트랜잭션, HikariCP 풀링, Flyway 마이그레이션, 리포지토리 패턴. |
| `kotlin-ktor-patterns` | Ktor 서버 패턴 — 라우팅 DSL, 플러그인, 인증, Koin DI, kotlinx.serialization, WebSocket, testApplication 테스트. |
| `java-coding-standards` | Spring Boot 서비스용 Java 코딩 표준 — 네이밍, 불변성, Optional, 스트림, 예외, 제네릭, 프로젝트 구조. |
| `jpa-patterns` | Spring Boot에서 엔티티 설계·연관관계·쿼리 최적화·트랜잭션·감사·인덱싱·페이징·풀링을 위한 JPA/Hibernate 패턴. |
| `springboot-patterns` | Spring Boot 아키텍처 패턴 — REST API 설계, 계층형 서비스, 데이터 접근, 캐싱, 비동기 처리, 로깅. Java 백엔드용. |
| `springboot-security` | Java Spring Boot의 인증/인가·검증·CSRF·시크릿·헤더·레이트리밋·의존성 보안을 위한 Spring Security 모범 사례. |
| `springboot-tdd` | JUnit 5·Mockito·MockMvc·Testcontainers·JaCoCo로 하는 Spring Boot TDD. 기능 추가·버그 수정·리팩터링 시 사용. |
| `springboot-verification` | Spring Boot 검증 루프 — 빌드, 정적 분석, 커버리지 테스트, 보안 스캔, 릴리스/PR 전 diff 리뷰. |
| `django-patterns` | Django 아키텍처 패턴 — DRF로 REST API 설계, ORM 모범 사례, 캐싱, 시그널, 미들웨어, 프로덕션급 앱. |
| `django-security` | Django 보안 모범 사례 — 인증·인가, CSRF, SQL 인젝션·XSS 방지, 안전한 배포 구성. |
| `django-tdd` | pytest-django·TDD·factory_boy·모킹·커버리지·DRF API 테스트를 활용한 Django 테스트 전략. |
| `django-verification` | Django 검증 루프 — 마이그레이션, 린트, 커버리지 테스트, 보안 스캔, 배포 준비 점검. |
| `laravel-patterns` | Laravel 아키텍처 패턴 — 라우팅/컨트롤러, Eloquent ORM, 서비스 계층, 큐, 이벤트, 캐싱, API 리소스. |
| `laravel-security` | Laravel 보안 모범 사례 — 인증/인가, 검증, CSRF, 대량 할당, 파일 업로드, 시크릿, 레이트리밋, 안전한 배포. |
| `laravel-tdd` | PHPUnit·Pest, 팩토리, DB 테스트, 페이크, 커버리지 목표로 하는 Laravel TDD. |
| `laravel-verification` | Laravel 검증 루프 — 환경 점검, 린트, 정적 분석, 커버리지 테스트, 보안 스캔, 배포 준비. |
| `perl-patterns` | 견고·유지보수 가능한 Perl 앱을 위한 모던 Perl 5.36+ 관용구·모범 사례·규칙. |
| `perl-security` | 오염 모드, 입력 검증, 안전한 프로세스 실행, DBI 파라미터 쿼리, 웹 보안(XSS/SQLi/CSRF), perlcritic 정책 등 Perl 보안 가이드. |
| `perl-testing` | Test2::V0·Test::More·prove·모킹·Devel::Cover·TDD를 활용한 Perl 테스트 패턴. |
| `cpp-coding-standards` | C++ 코어 가이드라인 기반 코딩 표준. 모던·안전·관용적 C++ 작성·리뷰·리팩터링 시 사용. |
| `cpp-testing` | C++ 테스트 작성/수정, GoogleTest/CTest 설정, 실패·불안정 테스트 진단, 커버리지/새니타이저 추가 시 사용. |
| `swift-actor-persistence` | Swift에서 actor로 스레드 안전한 데이터 영속화 — 메모리 캐시 + 파일 저장, 설계로 데이터 경쟁 제거. |
| `swift-concurrency-6-2` | Swift 6.2 동시성 — 기본 단일 스레드, @concurrent로 명시적 백그라운드 오프로드, main actor 격리. |
| `swift-protocol-di-testing` | 테스트 가능한 Swift를 위한 프로토콜 기반 DI — 파일시스템·네트워크·외부 API를 Swift Testing으로 모킹. |
| `swiftui-patterns` | @Observable 상태 관리, 뷰 구성, 내비게이션, 성능 최적화 등 모던 iOS/macOS SwiftUI 아키텍처 패턴. |
| `android-clean-architecture` | Android/Kotlin 멀티플랫폼용 클린 아키텍처 — 모듈 구조, 의존성 규칙, 유스케이스, 리포지토리, 데이터 계층 패턴. |
| `compose-multiplatform-patterns` | KMP용 Compose Multiplatform/Jetpack Compose 패턴 — 상태 관리, 내비게이션, 테마, 성능, 플랫폼별 UI. |
| `flutter-dart-code-review` | 라이브러리 무관 Flutter/Dart 코드 리뷰 체크리스트 — 위젯 모범 사례, 상태 관리(BLoC·Riverpod·Provider 등), 성능, 접근성. |
| `foundation-models-on-device` | Apple FoundationModels로 온디바이스 LLM — 텍스트 생성, @Generable 가이드 생성, 도구 호출, iOS 26+ 스냅샷 스트리밍. |
| `liquid-glass-design` | iOS 26 리퀴드 글래스 디자인 시스템 — SwiftUI·UIKit·WidgetKit용 동적 유리 재질, 블러·반사·인터랙티브 변형. |
| `frontend-patterns` | React·Next.js·상태 관리·성능 최적화·UI 모범 사례를 위한 프론트엔드 개발 패턴. |
| `backend-patterns` | Node.js·Express·Next.js API 라우트용 백엔드 아키텍처, API 설계, DB 최적화, 서버사이드 모범 사례. |
| `nextjs-turbopack` | Next.js 16+와 Turbopack — 증분 번들링, FS 캐싱, 개발 속도, Turbopack vs webpack 선택 기준. |
| `nuxt4-patterns` | Nuxt 4 앱 패턴 — 하이드레이션 안전성, 성능, 라우트 규칙, 지연 로딩, useFetch/useAsyncData로 SSR 안전 데이터 페칭. |
| `bun-runtime` | 런타임·패키지 매니저·번들러·테스트 러너로서의 Bun. Bun vs Node 선택, 마이그레이션, Vercel 지원. |
| `api-design` | 리소스 네이밍, 상태 코드, 페이지네이션, 필터링, 에러 응답, 버저닝, 레이트리밋 등 프로덕션 REST API 설계 패턴. |
| `docker-patterns` | 로컬 개발용 Docker/Docker Compose 패턴 — 컨테이너 보안, 네트워크, 볼륨 전략, 멀티서비스 오케스트레이션. |
| `deployment-patterns` | 배포 워크플로, CI/CD 파이프라인, Docker 컨테이너화, 헬스체크, 롤백 전략, 프로덕션 준비 체크리스트. |
| `database-migrations` | PostgreSQL·MySQL 및 주요 ORM(Prisma·Drizzle·Django·TypeORM·golang-migrate)에서 스키마 변경·데이터 마이그레이션·롤백·무중단 배포 모범 사례. |
| `postgres-patterns` | 쿼리 최적화, 스키마 설계, 인덱싱, 보안을 위한 PostgreSQL 패턴. Supabase 모범 사례 기반. |
| `clickhouse-io` | 고성능 분석 워크로드를 위한 ClickHouse 패턴 — 쿼리 최적화, 분석, 데이터 엔지니어링 모범 사례. |
| `pytorch-patterns` | 견고·효율·재현 가능한 학습 파이프라인·모델 아키텍처·데이터 로딩을 위한 PyTorch 딥러닝 패턴·모범 사례. |

<a id="2"></a>
## 2. 엔지니어링 워크플로 · 품질

| 스킬 | 설명 |
| --- | --- |
| `tdd-workflow` | 신규 기능·버그 수정·리팩터링 시 사용. 단위·통합·E2E 포함 80%+ 커버리지로 TDD 강제. |
| `e2e-testing` | Playwright E2E 테스트 패턴, 페이지 오브젝트 모델, 설정, CI/CD 통합, 아티팩트 관리, 불안정 테스트 전략. |
| `verification-loop` | Claude Code 세션을 위한 종합 검증 시스템. |
| `security-review` | 인증 추가, 사용자 입력 처리, 시크릿 관리, API 엔드포인트 생성, 결제/민감 기능 구현 시 사용. 종합 보안 체크리스트·패턴. |
| `security-scan` | AgentShield로 Claude Code 설정(.claude/)의 보안 취약점·오설정·인젝션 위험 스캔. CLAUDE.md·settings.json·MCP·훅·에이전트 점검. |
| `browser-qa` | 브라우저 자동화(MCP/Playwright)로 라이브 페이지를 실제 사용자처럼 조작해 UI 동작·레이아웃·폼·접근성 자동 검증. 배포/PR 전 스모크 테스트. |
| `benchmark` | PR 전후 성능을 측정해 베이스라인을 잡고 회귀 탐지. 브라우저 실측 지표 기반 페이지 성능 진단. |
| `design-system` | 코드베이스를 분석해 일관된 디자인 시스템을 생성하거나 기존 UI의 시각적 일관성을 감사(audit). |
| `codebase-onboarding` | 낯선 코드베이스를 분석해 아키텍처 다이어그램·핵심 진입점·컨벤션·시작용 CLAUDE.md를 담은 온보딩 가이드 생성. |
| `architecture-decision-records` | 세션 중 내린 아키텍처 결정을 구조화된 ADR로 기록. 결정 순간 자동 감지, 맥락·대안·근거 문서화. |
| `strategic-compact` | 임의 자동 압축 대신 논리적 구간에서 수동 컨텍스트 압축을 제안해 작업 단계 간 컨텍스트 보존. |
| `context-budget` | 에이전트·스킬·MCP·규칙이 소비하는 컨텍스트 윈도를 감사. 비대·중복 요소 식별, 토큰 절감 제안. |
| `search-first` | 코딩보다 리서치 우선 워크플로. 커스텀 코드 작성 전 기존 도구·라이브러리·패턴 탐색, 리서처 에이전트 호출. |
| `rules-distill` | 스킬을 스캔해 교차 원칙을 추출·정제해 규칙 파일로 추가·수정·생성. |
| `skill-stocktake` | Claude 스킬·명령어 품질 감사. 빠른 스캔(변경분만)과 전체 재고 모드, 순차 서브에이전트 배치 평가. |
| `skill-comply` | 스킬·규칙·에이전트 정의가 실제로 지켜지는지 시각화 — 3단계 엄격도 시나리오 자동 생성, 에이전트 실행, 행동 시퀀스 분류, 도구 호출 타임라인과 준수율 리포트. |
| `product-lens` | 기능 착수 전 '왜'를 검증하는 프로덕트 진단. YC 오피스아워식 질문으로 아이디어를 스펙으로 정리. |
| `click-path-audit` | 모든 버튼/터치포인트를 전체 상태 변화 시퀀스로 추적해, 개별 기능은 되지만 서로 상쇄되거나 잘못된 최종 상태를 만드는 버그 탐지. 리팩터 후 사용. |
| `canary-watch` | 배포 후 URL을 루프로 모니터링하며 회귀를 감시하는 포스트 배포 카나리. |
| `safety-guard` | 파괴적 작업 방지 가드 — 디렉터리 편집 제한, careful 모드 등으로 프로덕션/자율 실행 중 위험 작업 차단. |

<a id="3"></a>
## 3. AI · 에이전트 · 자동화

| 스킬 | 설명 |
| --- | --- |
| `claude-api` | Python·TypeScript용 Anthropic Claude API 패턴 — Messages API, 스트리밍, 도구 사용, 비전, 확장 사고, 배치, 프롬프트 캐싱, Claude Agent SDK. |
| `mcp-server-patterns` | Node/TypeScript SDK로 MCP 서버 구축 — 도구·리소스·프롬프트·Zod 검증, stdio vs Streamable HTTP. |
| `agentic-engineering` | 평가 우선 실행, 분해, 비용 인식 모델 라우팅으로 에이전트 엔지니어처럼 작업. |
| `agent-eval` | 코딩 에이전트(Claude Code·Aider·Codex 등)를 커스텀 태스크로 정면 비교 — 통과율·비용·시간·일관성 지표. |
| `agent-harness-construction` | AI 에이전트의 액션 공간·도구 정의·관찰 형식을 설계·최적화해 완료율 향상. |
| `ai-first-engineering` | AI 에이전트가 구현 산출물 대부분을 생성하는 팀 엔지니어링 운영 모델. |
| `ai-regression-testing` | AI 보조 개발용 회귀 테스트 전략. 샌드박스 API 테스트, DB 비의존, 자동 결함 점검, AI 사각지대 포착. |
| `continuous-learning` | Claude Code 세션에서 재사용 패턴을 자동 추출해 학습된 스킬로 저장. |
| `continuous-learning-v2` | 훅으로 세션을 관찰해 신뢰도 점수가 있는 원자적 본능을 만들고 스킬/명령어/에이전트로 진화시키는 본능 기반 학습 시스템. |
| `eval-harness` | 평가 주도 개발(EDD) 원칙을 구현한 Claude Code 세션용 공식 평가 프레임워크. |
| `autonomous-loops` | 자율 Claude Code 루프의 패턴·아키텍처 — 단순 순차 파이프라인부터 RFC 기반 멀티에이전트 DAG까지. |
| `continuous-agent-loop` | 품질 게이트·평가·복구 제어를 갖춘 연속 자율 에이전트 루프 패턴. |
| `blueprint` | 한 줄 목표를 멀티세션·멀티에이전트 프로젝트의 단계별 빌드 계획으로 변환. 단계별 독립 브리핑, 대립 리뷰 게이트, 의존성 그래프. |
| `team-builder` | 병렬 팀을 구성·파견하는 대화형 에이전트 선택기. |
| `dmux-workflows` | dmux(AI 에이전트용 tmux 페인 매니저)로 멀티에이전트 오케스트레이션. Claude Code·Codex·OpenCode 등에서 병렬 에이전트 워크플로. |
| `claude-devfleet` | Claude DevFleet로 멀티에이전트 코딩 조율 — 프로젝트 계획, 격리된 워크트리에서 병렬 에이전트 파견, 진행 모니터링, 구조화 리포트. |
| `ralphinho-rfc-pipeline` | RFC 주도 멀티에이전트 DAG 실행 패턴 — 품질 게이트, 머지 큐, 작업 단위 오케스트레이션. |
| `enterprise-agent-ops` | 관측성·보안 경계·수명주기 관리로 장기 실행 에이전트 워크로드 운영. |
| `iterative-retrieval` | 서브에이전트 컨텍스트 문제 해결을 위한 점진적 컨텍스트 검색 개선 패턴. |
| `cost-aware-llm-pipeline` | LLM API 비용 최적화 패턴 — 태스크 복잡도 기반 모델 라우팅, 예산 추적, 재시도 로직, 프롬프트 캐싱. |
| `prompt-optimizer` | 원시 프롬프트를 분석해 의도·격차를 파악하고 ECC 컴포넌트(스킬/명령어/에이전트/훅)를 매칭해 바로 붙여넣을 최적화 프롬프트 출력. 자문 전용. |
| `nanoclaw-repl` | ECC가 claude -p 위에 구축한 무의존성 세션 인식 REPL인 NanoClaw v2 운영·확장. |
| `regex-vs-llm-structured-text` | 구조화 텍스트 파싱에 정규식과 LLM 중 무엇을 쓸지 결정하는 프레임워크 — 정규식으로 시작, 저신뢰 엣지케이스에만 LLM 추가. |
| `content-hash-cache-pattern` | SHA-256 콘텐츠 해시로 값비싼 파일 처리 결과 캐싱 — 경로 무관, 자동 무효화, 서비스 계층 분리. |
| `plankton-code-quality` | Plankton으로 작성 시점 코드 품질 강제 — 훅으로 매 파일 편집마다 자동 포맷·린트·Claude 수정. |
| `configure-ecc` | Everything Claude Code 대화형 설치기 — 스킬·규칙을 사용자/프로젝트 레벨로 선택 설치, 경로 검증, 설치 파일 최적화. |
| `santa-method` | 수렴 루프가 있는 멀티에이전트 대립 검증 — 두 독립 리뷰 에이전트가 모두 통과해야 산출물 배포. |

<a id="4"></a>
## 4. 리서치 · 콘텐츠 · 비즈니스

| 스킬 | 설명 |
| --- | --- |
| `deep-research` | firecrawl·exa MCP로 다중 소스 심층 리서치. 웹 검색·종합·출처 명시 리포트. 어떤 주제든 근거 있는 철저한 리서치가 필요할 때. |
| `exa-search` | Exa MCP 신경망 검색 — 웹·코드·기업 리서치, 인물 조회, AI 심층 리서치. |
| `documentation-lookup` | 학습 데이터 대신 Context7 MCP로 최신 라이브러리·프레임워크 문서 사용. 설정·API·예제·프레임워크 언급 시 활성화. |
| `market-research` | 시장 조사·경쟁 분석·투자 실사·산업 인텔리전스 — 출처 명시, 의사결정 지향 요약. |
| `content-engine` | X·LinkedIn·TikTok·YouTube·뉴스레터용 플랫폼 네이티브 콘텐츠 시스템 — 게시물·스레드·스크립트·콘텐츠 캘린더. |
| `crosspost` | X·LinkedIn·Threads·Bluesky 다중 플랫폼 콘텐츠 배포. 플랫폼별 적응, 동일 콘텐츠 크로스포스트 지양. |
| `x-api` | X/Twitter API 연동 — 트윗·스레드 게시, 타임라인·검색·분석. OAuth 인증, 레이트리밋. |
| `article-writing` | 제공된 예시·브랜드 가이드에서 도출한 목소리로 글·가이드·블로그·튜토리얼·뉴스레터 작성. |
| `frontend-slides` | 처음부터 또는 PPT 변환으로 애니메이션 풍부한 HTML 프레젠테이션 제작. |
| `investor-materials` | 피치덱·원페이저·투자 메모·액셀러레이터 지원서·재무 모델·펀딩 자료 작성·업데이트. |
| `investor-outreach` | 펀딩용 콜드 이메일·소개 문구·팔로업·업데이트 메일 등 투자자 커뮤니케이션 작성. |
| `video-editing` | AI 보조 영상 편집 워크플로 — 촬영본을 FFmpeg·Remotion·ElevenLabs·fal.ai·Descript로 컷·구성·증강. |
| `videodb` | 영상·오디오 보기·이해·행동 — 로컬/URL/RTSP/라이브 취득, 프레임 추출, 시각/의미 인덱스 구축, 재생 스트림 제공. |
| `fal-ai-media` | fal.ai MCP로 통합 미디어 생성 — 이미지·영상·오디오. 텍스트→이미지(Nano Banana), 영상(Seedance·Kling·Veo 3), TTS 등. |
| `nutrient-document-processing` | Nutrient DWS API로 문서 처리·변환·OCR·추출·편집·서명·양식 채우기. PDF·DOCX·XLSX·PPTX·HTML·이미지 지원. |
| `data-scraper-agent` | 채용·가격·뉴스·GitHub·스포츠 등 공개 소스용 완전 자동 AI 데이터 수집 에이전트. 스케줄 스크래핑. |
| `visa-doc-translate` | 비자 신청 서류(이미지)를 영어로 번역하고 원문+번역을 담은 이중언어 PDF 생성. |

<a id="5"></a>
## 5. 도메인 특화 (물류 · 무역 · 제조 등)

| 스킬 | 설명 |
| --- | --- |
| `customs-trade-compliance` | 관세 서류, 관세 분류, 관세 최적화, 제재 대상 스크리닝, 다국적 규제 준수 전문성(15년+ 경력 기반). |
| `energy-procurement` | 전력·가스 조달, 전기요금 최적화, 수요전력 관리, 재생에너지 PPA 평가, 다중 시설 에너지 비용 관리 전문성. |
| `inventory-demand-planning` | 다지점 소매용 수요 예측, 안전재고 최적화, 보충 계획, 프로모션 부양 추정 전문성. |
| `logistics-exception-management` | 화물 예외·지연·파손·분실·운송사 분쟁 대응 전문성(15년+ 운영 경력), 에스컬레이션 포함. |
| `production-scheduling` | 이산·배치 제조의 생산 스케줄링, 작업 순서, 라인 밸런싱, 교체 최적화, 병목 해소 전문성. |
| `quality-nonconformance` | 규제 제조의 품질 관리, 부적합 조사, 근본원인 분석, 시정조치, 공급사 품질 관리 전문성(FDA·IATF 16949·AS9100). |
| `returns-reverse-logistics` | 반품 승인·입고·검수·처분 결정·환불·사기 탐지·보증 청구 관리 전문성(15년+ 반품 운영). |
| `carrier-relationship-management` | 운송사 포트폴리오 관리, 운임 협상, 성과 추적, 화물 배정, 전략적 운송사 관계 유지 전문성(15년+). |

<a id="6"></a>
## 6. Figma (디자인 ↔ 코드)

| 스킬 | 설명 |
| --- | --- |
| `figma-use` | use_figma 도구 호출 전 반드시 로드하는 필수 선행 스킬. 스킵하면 디버깅 어려운 실패 유발. |
| `figma-design-to-code` | get_design_context 호출 전 필수 선행. Figma 디자인을 구현·빌드할 때 트리거(디자인→코드). |
| `figma-generate-design` | 앱 페이지·뷰·다중 섹션 레이아웃을 Figma로 변환할 때 figma-use와 함께 사용(코드→Figma). |
| `figma-generate-library` | 코드베이스에서 프로급 디자인 시스템 구축 — 변수/토큰, 컴포넌트 라이브러리, 개별 컴포넌트 생성. |
| `figma-code-connect` | Figma 컴포넌트를 코드 스니펫에 매핑하는 Code Connect 템플릿 생성·관리. |
| `figma-implement-motion` | Figma 모션·애니메이션을 프로덕션 코드로 변환. 'Figma 모션 구현' 트리거. |
| `figma-swiftui` | SwiftUI ↔ Figma 양방향 변환. Swift·iOS·iPhone·iPad 언급 시 사용. |
| `figma-create-new-file` | create_new_file 호출 전 필수 선행. 새 빈 Figma 파일 요청 시 트리거. |
| `figma-generate-diagram` | generate_diagram 호출 전 필수 선행. 다이어그램 생성·그리기 요청 시 트리거. |
| `figma-use-figjam` | FigJam 컨텍스트에서 use_figma 도구 사용 보조. figma-use와 함께 사용. |
| `figma-use-motion` | use_figma용 모션/애니메이션 컨텍스트 — 수동 키프레임·이징·타임라인으로 노드 애니메이션. figma-use와 함께 로드. |
| `figma-use-slides` | Slides 컨텍스트에서 use_figma 도구 사용 보조. figma-use와 함께 사용. |
| `generate-project-plan` | PRD와 코드베이스 맥락으로 FigJam 프로젝트 계획 보드 생성. 리서치→섹션 제안→심층 리서치→콘텐츠→FigJam 생성 대화형 플로. |
| `video-interaction-mapper` | UI 화면 녹화를 분석해 인터랙션 상태를 Figma로 매핑. '녹화에서 상태 추출' 트리거. |

<a id="기타"></a>
## 기타

| 스킬 | 설명 |
| --- | --- |
| `project-guidelines-example` | 실제 프로덕션 앱 기반 프로젝트별 스킬 템플릿 예시. |

---

## 출처

- **Figma 스킬 (14개)**: [minimeeme/mcp-server-guide](https://github.com/minimeeme/mcp-server-guide) — Figma MCP 연동
- **그 외 (125개)**: [minimeeme/Claude_Upgrade](https://github.com/minimeeme/Claude_Upgrade) — Everything Claude Code(ECC) 큐레이션

