---
name: narra:prep
description: Prepare for a scene with character dynamics, tensions, and dramatic irony
allowed-tools:
  - mcp__narra__query
  - mcp__narra__session
  - Task
---

# Scene Prep

Prepare for writing a scene by analyzing character dynamics, knowledge asymmetries, and dramatic irony opportunities.

## Usage

/narra:prep <natural language description>

## Smart Dispatch

**Simple** (1-2 named characters, straightforward):
Run directly:
1. `mcp__narra__query(operation="scene_planning", character_ids=["char1", "char2"])` — pairwise dynamics
2. `mcp__narra__query(operation="knowledge_asymmetries", character_ids=["char1", "char2"])` — who knows what
3. `mcp__narra__query(operation="dramatic_irony_report", character_id="char1")` — irony opportunities

Present a structured scene brief.

**Complex** (multiple characters, specific tone/location, deep analysis needed):
Launch the **scene-architect** agent via Task tool. Pass the user's natural language as context.

**Ambiguous**: Ask the user to name the characters involved.

## Example

```
/narra:prep matei and elena confrontation at the manor
> [Scene brief with dynamics, knowledge gaps, irony opportunities]

/narra:prep the council meeting where everyone has secrets
> [Launches scene-architect agent for complex multi-character analysis]
```
