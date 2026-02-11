# Narra Plugin Patterns

## Tool Selection Guide

When the user asks about **characters** → use `/narra:dossier` or `query(operation="character_dossier")`
When the user wants to **write a scene** → use `/narra:prep` or `query(operation="scene_planning")`
When the user asks "**who knows what**" → use `query(operation="knowledge_asymmetries")` or `query(operation="dramatic_irony_report")`
When the user wants to **create** something → use `/narra:build` or the appropriate `mutate` operation
When the user wants to **find** something → use `/narra:search` with smart routing
When the user asks about **consistency** → use `/narra:audit` or `query(operation="validate_entity")`
When the user asks about **relationships** → use `query(operation="connection_path")` or `generate_graph`

## Search Decision Tree

- **Name or ID** → `query(operation="search", query="...")`
- **Theme or concept** → `query(operation="unified_search", mode="semantic", query="...")`
- **Name + concept mix** → `query(operation="unified_search", mode="hybrid", query="...")`
- **Best precision needed** → `query(operation="unified_search", mode="reranked", query="...")`
- **Not sure** → use `unified_search` with `mode="hybrid"` (works well for everything)

## Conventions

- Always check session context first: `session(operation="get_context")` reveals pinned entities and recent accesses
- Pin frequently-discussed entities: `session(operation="pin_entity", entity_id="character:name")`
- After creating entities, suggest adding relationships and recording knowledge
- Use `validate_entity` after significant changes to catch inconsistencies
- Character IDs are lowercase: `character:matei`, `location:manor`, `event:betrayal`

## Operation Quick Reference

### Most Useful Queries
- `overview` — entity counts and world summary
- `unified_search` — search by meaning/theme/hybrid (`mode`: "semantic", "hybrid", "reranked")
- `character_dossier` — full character profile
- `scene_planning` — prep scene with character dynamics
- `dramatic_irony_report` — knowledge asymmetries for drama
- `unresolved_tensions` — active narrative tensions
- `arc_history` — character arc trajectory over time
- `detect_phases` — discover narrative phases via temporal-semantic clustering
- `query_around` — find entities narratively close to an anchor
- `detect_transitions` — identify entities bridging narrative phases

### Most Useful Mutations
- `create_character` — with name, description, wound, desire, secret, contradiction
- `create_relationship` — link two entities with type and description
- `record_knowledge` — what a character knows/believes (with truth value)
- `batch_record_knowledge` — batch knowledge recording
- `update` — modify any entity field
- `protect_entity` — prevent accidental deletion

### Tips
- Composite reports (`character_dossier`, `scene_planning`, `dramatic_irony_report`) accept `detail_level`: "summary", "standard", or "full"
- Pass `token_budget` on any query to control response size (defaults: 4000 for composites, 2000 for searches, 1000 for lookups)
