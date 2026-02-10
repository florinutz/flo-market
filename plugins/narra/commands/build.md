---
name: narra:build
description: Create characters, locations, events with full relationship mapping
allowed-tools:
  - mcp__narra__mutate
  - mcp__narra__query
  - mcp__narra__session
  - Task
---

# Build World

Create narrative entities with relationships, knowledge states, and validation.

## Usage

/narra:build <natural language description>

## Smart Dispatch

**Simple** (single entity creation):
Run directly:
1. Parse the description for entity type and attributes
2. For characters: `mcp__narra__mutate(operation="create_character", name="...", description="...", ...)` — include wound, desire, secret, contradiction if provided
3. For locations: `mcp__narra__mutate(operation="create_location", name="...", description="...", ...)`
4. For events: `mcp__narra__mutate(operation="create_event", name="...", description="...", ...)`
5. After creation: suggest adding relationships and knowledge

**Complex** (multiple entities, relationship web, full character development):
Launch the **world-builder** agent via Task tool. The agent will elicit full character details (wound/desire/secret/contradiction), create entities, map relationships, and record knowledge states.

## Example

```
/narra:build a mysterious stranger named Victor who arrives at the manor
> Created character:victor — "A mysterious stranger..."
> Consider: /narra:build add relationship between victor and matei

/narra:build an entire faction of rebels with their leader, base, and key events
> [Launches world-builder agent for complex multi-entity creation]
```
