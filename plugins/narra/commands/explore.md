---
name: narra:explore
description: Discover and explore the narrative world interactively
allowed-tools:
  - mcp__narra__query
  - mcp__narra__session
  - Task
  - AskUserQuestion
---

# Explore World

Interactively discover the narrative world — characters, tensions, relationships, and story structure.

This command always launches the **onboarding-guide** agent for a deep, interactive exploration.

## Usage

/narra:explore [topic]

## Behavior

Launch the `onboarding-guide` agent via the Task tool with subagent_type set to the narra onboarding-guide agent.

The agent will:
1. Query world Overview + CentralityMetrics + DramaticIronyReport
2. Present interactive menus (via AskUserQuestion) generated from actual DB content
3. Let the user drill into characters, tensions, relationships, knowledge gaps
4. Save exploration results to `.narra/onboarding.json`

If [topic] is provided, tell the agent to focus exploration on that topic.

## Example

```
/narra:explore
> Discovering your narrative world...
> [Interactive menus based on actual world content]

/narra:explore relationships
> Focusing exploration on relationship dynamics...
```
