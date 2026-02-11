---
name: narra:search
description: Smart search across the narrative world — keyword, semantic, or hybrid
allowed-tools:
  - mcp__narra__query
---

# Smart Search

Search the narrative world with automatic routing between keyword, semantic, and hybrid search.

## Usage

/narra:search <natural language query>

## Search Routing

Analyze the query to pick the best search strategy:

**Keyword search** (`operation="search"`) — when the query is:
- A specific name: "matei", "the manor"
- An exact phrase: "blood oath"
- An ID: "character:elena"

**Semantic search** (`operation="unified_search", mode="semantic"`) — when the query is:
- A theme or concept: "betrayal", "forbidden love"
- A description: "characters hiding something"
- A question: "who has the most secrets?"

**Hybrid search** (`operation="unified_search", mode="hybrid"`) — when the query:
- Mixes names and concepts: "matei's secrets"
- Could benefit from both: "events at the manor involving betrayal"

**Reranked search** (`operation="unified_search", mode="reranked"`) — when you need best precision:
- Complex queries where ranking quality matters most
- Use when hybrid results need further refinement

Always use `limit=10` by default. Present results with relevance scores when available.

## Example

```
/narra:search elena
> [Keyword search results for "elena"]

/narra:search characters who fear abandonment
> [Semantic search results for abandonment theme]

/narra:search matei's relationship with the old manor
> [Hybrid search combining name + concept]
```
