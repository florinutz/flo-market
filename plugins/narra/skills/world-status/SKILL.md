---
description: Quick world status — entity counts, health metrics, and recent activity
user_invocable: true
---

# World Status

Quick overview of the narrative world state.

<instructions>

Run these queries and compile a status dashboard:

### Step 1: Get world overview
```
mcp__narra__query(operation="overview")
```

### Step 2: Check embedding health
```
mcp__narra__query(operation="embedding_health")
```

### Step 3: Get session context
```
mcp__narra__session(operation="get_context")
```

### Step 4: Present dashboard

Format the results as:

```
## World Status

### Entities
Characters: N | Locations: N | Events: N | Scenes: N
Relationships: N | Knowledge entries: N

### Health
Embeddings: X up to date, Y stale
[If stale > 0: "Run query(operation='backfill_embeddings') to refresh"]

### Session
Pinned: [entity list or "none"]
Recent: [top 5 recent entities or "none"]
Pending decisions: N
```

Keep it concise — this is a quick status check, not a deep analysis.

</instructions>
