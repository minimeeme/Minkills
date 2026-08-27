---
name: exa-search
description: "Exa MCP를 통한 웹·코드·기업 리서치용 뉴럴 검색. 웹 검색, 코드 예제, 기업 정보, 인물 조회, 또는 Exa 뉴럴 검색 엔진 기반 AI 심층 리서치가 필요할 때 사용."
origin: ECC
---

# Exa Search

Neural search for web content, code, companies, and people via the Exa MCP server.

## When to Activate

- User needs current web information or news
- Searching for code examples, API docs, or technical references
- Researching companies, competitors, or market players
- Finding professional profiles or people in a domain
- Running background research for any development task
- User says "search for", "look up", "find", or "what's the latest on"

## MCP Requirement

Exa MCP server must be configured. Add to `~/.claude.json`:

```json
"exa-web-search": {
  "command": "npx",
  "args": ["-y", "exa-mcp-server"],
  "env": { "EXA_API_KEY": "YOUR_EXA_API_KEY_HERE" }
}
```

Get an API key at [exa.ai](https://exa.ai).
This repo's current Exa setup documents the tool surface exposed here: `web_search_exa` and `get_code_context_exa`.
If your Exa server exposes additional tools, verify their exact names before depending on them in docs or prompts.

## Core Tools

### web_search_exa
General web search for current information, news, or facts.

```
web_search_exa(query: "latest AI developments 2026", numResults: 5)
```

**Parameters:**

| Param | Type | Default | Notes |
|-------|------|---------|-------|
| `query` | string | required | Search query |
| `numResults` | number | 8 | Number of results |
| `type` | string | `auto` | Search mode |
| `livecrawl` | string | `fallback` | Prefer live crawling when needed |
| `category` | string | none | Optional focus such as `company` or `research paper` |

### get_code_context_exa
Find code examples and documentation from GitHub, Stack Overflow, and docs sites.

```
get_code_context_exa(query: "Python asyncio patterns", tokensNum: 3000)
```

**Parameters:**

| Param | Type | Default | Notes |
|-------|------|---------|-------|
| `query` | string | required | Code or API search query |
| `tokensNum` | number | 5000 | Content tokens (1000-50000) |

## Usage Patterns

### Quick Lookup
```
web_search_exa(query: "Node.js 22 new features", numResults: 3)
```

### Code Research
```
get_code_context_exa(query: "Rust error handling patterns Result type", tokensNum: 3000)
```

### Company or People Research
```
web_search_exa(query: "Vercel funding valuation 2026", numResults: 3, category: "company")
web_search_exa(query: "site:linkedin.com/in AI safety researchers Anthropic", numResults: 5)
```

### Technical Deep Dive
```
web_search_exa(query: "WebAssembly component model status and adoption", numResults: 5)
get_code_context_exa(query: "WebAssembly component model examples", tokensNum: 4000)
```

## Tips

- Use `web_search_exa` for current information, company lookups, and broad discovery
- Use search operators like `site:`, quoted phrases, and `intitle:` to narrow results
- Lower `tokensNum` (1000-2000) for focused code snippets, higher (5000+) for comprehensive context
- Use `get_code_context_exa` when you need API usage or code examples rather than general web pages

## Related Skills

- `deep-research` — Full research workflow using firecrawl + exa together
- `market-research` — Business-oriented research with decision frameworks
