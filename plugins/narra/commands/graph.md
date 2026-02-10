---
name: narra:graph
description: Generate visual relationship graphs as Mermaid diagrams
allowed-tools:
  - mcp__narra__generate_graph
  - mcp__narra__query
---

# Relationship Graph

Generate Mermaid relationship diagrams for the narrative world.

## Usage

/narra:graph [scope]

## Implementation

1. If no scope provided: `mcp__narra__generate_graph()` — full world graph
2. If scope is a character: `mcp__narra__generate_graph(center_entity="character:<id>", depth=2)` — ego graph
3. If scope is "tensions": First run `mcp__narra__query(operation="unresolved_tensions")`, then generate graph centered on tension participants
4. If scope is a type (e.g., "locations"): `mcp__narra__generate_graph(entity_types=["location"])`

The graph is saved to `.planning/exports/` as a Mermaid file. Tell the user the file path.

## Example

```
/narra:graph
> Generated full world graph → .planning/exports/world-graph.mmd

/narra:graph matei
> Generated ego graph for Matei → .planning/exports/matei-graph.mmd

/narra:graph tensions
> Generated tension relationship graph → .planning/exports/tensions-graph.mmd
```
