---
name: narra:status
description: Show world overview, health metrics, and active tensions
allowed-tools:
  - mcp__narra__query
  - mcp__narra__session
---

# World Status

Show comprehensive world state: entity counts, embedding health, session context, and active tensions.

## Usage

/narra:status

## Implementation

Run these queries in sequence and present a unified report:

1. **Overview**: `mcp__narra__query(operation="overview")` — entity counts by type
2. **Session**: `mcp__narra__session(operation="get_context")` — pinned entities, recent accesses, pending decisions
3. **Embedding Health**: `mcp__narra__query(operation="embedding_health")` — stale embeddings count
4. **Tensions**: `mcp__narra__query(operation="unresolved_tensions")` — active narrative tensions

Present results as a clean dashboard:

```
## World Status

### Entities
Characters: N | Locations: N | Events: N | Scenes: N

### Session
Pinned: [list] | Recent: [top 5] | Pending decisions: N

### Health
Embeddings: N/M up to date (X stale)

### Active Tensions
- [tension description] (characters involved, severity)
```
