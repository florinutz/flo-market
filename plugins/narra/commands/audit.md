---
name: narra:audit
description: Audit narrative consistency — find contradictions, knowledge conflicts, validation issues
allowed-tools:
  - mcp__narra__query
  - Task
---

# Consistency Audit

Find contradictions, knowledge conflicts, and validation issues in the narrative world.

## Usage

/narra:audit [natural language scope]

## Smart Dispatch

**Simple** (single entity or general check):
Run directly:
1. `mcp__narra__query(operation="validate_entity", entity_id="<id>")` — structural validation
2. `mcp__narra__query(operation="investigate_contradictions", entity_id="<id>")` — contradiction detection
3. `mcp__narra__query(operation="knowledge_conflicts")` — knowledge state conflicts

Present a consistency report with severity levels.

**Complex** (broad scope, fix suggestions needed, multi-entity):
Launch the **continuity-auditor** agent via Task tool.

## Example

```
/narra:audit elena's knowledge consistency
> [Validation report for elena with contradictions and knowledge conflicts]

/narra:audit the entire timeline for plot holes
> [Launches continuity-auditor agent for comprehensive audit]
```
