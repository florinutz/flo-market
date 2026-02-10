---
name: narra:dossier
description: Deep character dossier — psychology, relationships, arc, knowledge state
allowed-tools:
  - mcp__narra__query
  - mcp__narra__session
  - Task
---

# Character Dossier

Generate a comprehensive character profile with psychology, relationships, knowledge state, and arc trajectory.

## Usage

/narra:dossier <character name or description>

## Smart Dispatch

**Simple** (single character, quick overview):
Run directly:
1. `mcp__narra__query(operation="character_dossier", character_id="<id>")` — full dossier
2. Pin the character: `mcp__narra__session(operation="pin_entity", entity_id="character:<id>")`

Present the dossier in a readable format.

**Deep** (with arc analysis, relationship mapping, perception analysis):
Run additional queries:
1. Character dossier (as above)
2. `mcp__narra__query(operation="arc_history", character_id="<id>")` — arc trajectory
3. `mcp__narra__query(operation="relationship_strength_map", character_id="<id>")` — relationship web
4. `mcp__narra__query(operation="perception_gap", observer_id="<id>")` — how others see them vs reality

If the user asks for "deep dossier" or multiple characters, launch the **arc-tracker** and **relationship-mapper** agents.

## Example

```
/narra:dossier matei
> [Comprehensive dossier for Matei with psychology, relationships, knowledge]

/narra:dossier deep dive on elena's arc
> [Extended dossier with arc history, perception gaps, relationship map]
```
