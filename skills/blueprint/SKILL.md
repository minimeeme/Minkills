---
name: blueprint
description: "한 줄 목표를 멀티 세션·멀티 에이전트 엔지니어링 프로젝트를 위한 단계별 구축 계획으로 전환. 각 단계는 자체 완결적 context brief를 담아 새 에이전트가 아무 사전 정보 없이도 실행 가능. adversarial 리뷰 게이트, 의존성 그래프, 병렬 단계 탐지, anti-pattern 카탈로그, 계획 변경 프로토콜 포함. TRIGGER: 사용자가 복잡한 multi-PR 작업의 plan, blueprint, roadmap을 요청하거나 여러 세션이 필요한 작업을 설명할 때. DO NOT TRIGGER: 단일 PR 또는 3개 미만 tool call로 완료 가능하거나 사용자가 \"just do it\"이라 할 때"
origin: community
---

# Blueprint — Construction Plan Generator

Turn a one-line objective into a step-by-step construction plan that any coding agent can execute cold.

## When to Use

- Breaking a large feature into multiple PRs with clear dependency order
- Planning a refactor or migration that spans multiple sessions
- Coordinating parallel workstreams across sub-agents
- Any task where context loss between sessions would cause rework

**Do not use** for tasks completable in a single PR, fewer than 3 tool calls, or when the user says "just do it."

## How It Works

Blueprint runs a 5-phase pipeline:

1. **Research** — Pre-flight checks (git, gh auth, remote, default branch), then reads project structure, existing plans, and memory files to gather context.
2. **Design** — Breaks the objective into one-PR-sized steps (3–12 typical). Assigns dependency edges, parallel/serial ordering, model tier (strongest vs default), and rollback strategy per step.
3. **Draft** — Writes a self-contained Markdown plan file to `plans/`. Every step includes a context brief, task list, verification commands, and exit criteria — so a fresh agent can execute any step without reading prior steps.
4. **Review** — Delegates adversarial review to a strongest-model sub-agent (e.g., Opus) against a checklist and anti-pattern catalog. Fixes all critical findings before finalizing.
5. **Register** — Saves the plan, updates memory index, and presents the step count and parallelism summary to the user.

Blueprint detects git/gh availability automatically. With git + GitHub CLI, it generates full branch/PR/CI workflow plans. Without them, it switches to direct mode (edit-in-place, no branches).

## Examples

### Basic usage

```
/blueprint myapp "migrate database to PostgreSQL"
```

Produces `plans/myapp-migrate-database-to-postgresql.md` with steps like:
- Step 1: Add PostgreSQL driver and connection config
- Step 2: Create migration scripts for each table
- Step 3: Update repository layer to use new driver
- Step 4: Add integration tests against PostgreSQL
- Step 5: Remove old database code and config

### Multi-agent project

```
/blueprint chatbot "extract LLM providers into a plugin system"
```

Produces a plan with parallel steps where possible (e.g., "implement Anthropic plugin" and "implement OpenAI plugin" run in parallel after the plugin interface step is done), model tier assignments (strongest for the interface design step, default for implementation), and invariants verified after every step (e.g., "all existing tests pass", "no provider imports in core").

## Key Features

- **Cold-start execution** — Every step includes a self-contained context brief. No prior context needed.
- **Adversarial review gate** — Every plan is reviewed by a strongest-model sub-agent against a checklist covering completeness, dependency correctness, and anti-pattern detection.
- **Branch/PR/CI workflow** — Built into every step. Degrades gracefully to direct mode when git/gh is absent.
- **Parallel step detection** — Dependency graph identifies steps with no shared files or output dependencies.
- **Plan mutation protocol** — Steps can be split, inserted, skipped, reordered, or abandoned with formal protocols and audit trail.
- **Zero runtime risk** — Pure Markdown skill. The entire repository contains only `.md` files — no hooks, no shell scripts, no executable code, no `package.json`, no build step. Nothing runs on install or invocation beyond Claude Code's native Markdown skill loader.

## Installation

This skill ships with Everything Claude Code. No separate installation is needed when ECC is installed.

### Full ECC install

If you are working from the ECC repository checkout, verify the skill is present with:

```bash
test -f skills/blueprint/SKILL.md
```

To update later, review the ECC diff before updating:

```bash
cd /path/to/everything-claude-code
git fetch origin main
git log --oneline HEAD..origin/main       # review new commits before updating
git checkout <reviewed-full-sha>          # pin to a specific reviewed commit
```

### Vendored standalone install

If you are vendoring only this skill outside the full ECC install, copy the reviewed file from the ECC repository into `~/.claude/skills/blueprint/SKILL.md`. Vendored copies do not have a git remote, so update them by re-copying the file from a reviewed ECC commit rather than running `git pull`.

## Requirements

- Claude Code (for `/blueprint` slash command)
- Git + GitHub CLI (optional — enables full branch/PR/CI workflow; Blueprint detects absence and auto-switches to direct mode)

## Source

Inspired by antbotlab/blueprint — upstream project and reference design.
