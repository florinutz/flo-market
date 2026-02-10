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
- **Theme or concept** → `query(operation="semantic_search", query="...")`
- **Name + concept mix** → `query(operation="hybrid_search", query="...")`
- **Not sure** → use hybrid_search (works well for everything)

## Conventions

- Always check session context first: `session(operation="get_context")` reveals pinned entities and recent accesses
- Pin frequently-discussed entities: `session(operation="pin_entity", entity_id="character:name")`
- After creating entities, suggest adding relationships and recording knowledge
- Use `validate_entity` after significant changes to catch inconsistencies
- Character IDs are lowercase: `character:matei`, `location:manor`, `event:betrayal`

## Operation Quick Reference

### Most Useful Queries
- `overview` — entity counts and world summary
- `semantic_search` — find by meaning/theme
- `character_dossier` — full character profile
- `scene_planning` — prep scene with character dynamics
- `dramatic_irony_report` — knowledge asymmetries for drama
- `unresolved_tensions` — active narrative tensions
- `arc_history` — character arc trajectory over time

### Most Useful Mutations
- `create_character` — with name, description, wound, desire, secret, contradiction
- `create_relationship` — link two entities with type and description
- `record_knowledge` — what a character knows/believes (with truth value)
- `update` — modify any entity field
- `protect_entity` — prevent accidental deletion
