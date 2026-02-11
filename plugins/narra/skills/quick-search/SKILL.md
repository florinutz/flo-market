---
description: Smart search across the narrative world — routes between keyword, semantic, and hybrid search
user_invocable: true
args:
  - name: query
    description: What to search for
    required: true
---

# Quick Search

Quickly search across the narrative world with smart routing.

<instructions>

Analyze the user's search query: {{query}}

**Route the search based on query type:**

1. **If the query is a specific name, ID, or exact phrase** (e.g., "matei", "the manor", "character:elena"):
   Use keyword search:
   ```
   mcp__narra__query(operation="search", query="{{query}}", limit=10)
   ```

2. **If the query is a theme, concept, or descriptive** (e.g., "betrayal", "characters hiding something", "forbidden love"):
   Use semantic search:
   ```
   mcp__narra__query(operation="unified_search", mode="semantic", query="{{query}}", limit=10)
   ```

3. **If the query mixes names and concepts** (e.g., "matei's secrets", "events at the manor"):
   Use hybrid search:
   ```
   mcp__narra__query(operation="unified_search", mode="hybrid", query="{{query}}", limit=10)
   ```

**Present results** in a clean format:
- Entity name and type
- Relevance score (if available)
- Brief description or matching content
- Total results found

If no results found, suggest alternative search terms or a different search type.

</instructions>
