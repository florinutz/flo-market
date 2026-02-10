# Narra — Narrative Intelligence Plugin for Claude Code

Narra is a narrative intelligence engine that gives Claude deep understanding of story worlds: characters, relationships, knowledge states, dramatic irony, arc trajectories, and narrative tensions.

## What This Plugin Adds

- **8 workflow commands** — `/narra:explore`, `/narra:status`, `/narra:prep`, `/narra:audit`, `/narra:build`, `/narra:search`, `/narra:dossier`, `/narra:graph`
- **6 specialized agents** — scene-architect, world-builder, continuity-auditor, onboarding-guide, arc-tracker, relationship-mapper
- **5 skills** — quick-search, world-status, knowledge-audit, what-if, export-snapshot
- **Smart hooks** — session awareness, mutation guardrails, auto-suggestions, compaction safety

## Quick Start

1. **Explore your world**: `/narra:explore` — interactive discovery of characters, tensions, and structure
2. **Check status**: `/narra:status` — entity counts, health, active tensions
3. **Search anything**: `/narra:search <query>` — smart routing between keyword/semantic/hybrid

## Commands

| Command | Purpose |
|---------|---------|
| `/narra:explore [topic]` | Interactive world discovery (launches onboarding-guide agent) |
| `/narra:status` | World overview, health metrics, tensions dashboard |
| `/narra:prep <scene>` | Scene preparation with dynamics, irony, knowledge gaps |
| `/narra:audit [scope]` | Consistency audit — contradictions, conflicts, validation |
| `/narra:build <entity>` | Create entities with relationships and knowledge |
| `/narra:search <query>` | Smart search with auto-routing |
| `/narra:dossier <char>` | Deep character profile with psychology and arc |
| `/narra:graph [scope]` | Visual relationship graphs (Mermaid) |

## MCP Tools

The underlying narra MCP server provides 5 tools with 70 operations:

- **query** (40 ops) — search, analytics, arc tracking, perception, validation
- **mutate** (25 ops) — create, update, delete entities and knowledge
- **session** — context management, entity pinning
- **export_world** — full world export to YAML
- **generate_graph** — Mermaid relationship diagrams
