---
name: narra:scene
description: Play an interactive scene — write dialogue, direct NPCs, and explore character dynamics in real time
allowed-tools:
  - mcp__narra__query
  - mcp__narra__mutate
  - mcp__narra__session
  - mcp__narra__export_world
  - Task
  - AskUserQuestion
---

# Interactive Scene

Launch an interactive scene session where you write as your character (or direct from above) and NPCs respond with full narrative intelligence — filtered through their knowledge, perceptions, and voice.

This command always launches the **scene-runner** agent for a persistent, interactive play session.

## Usage

/narra:scene [character_ids...] ["narrative prompt"]

## Behavior

Launch the `scene-runner` agent via the Task tool with subagent_type set to the narra scene-runner agent.

Pass the full user input as context — character IDs and/or narrative prompt. The agent will:

1. Parse character IDs from the description, validate against world state
2. Load scene prep (pairwise dynamics) and character dossiers for all participants
3. Enrich with knowledge asymmetries, perception gaps, and universe facts
4. Present a scene context summary and enter the play loop
5. Play the scene in draft mode — world state is NOT modified until the user accepts changes at the end

## Example

```
/narra:scene alice bob "Alice arrives at the market"
> [Loads dynamics, dossiers, knowledge map — enters play loop]

/narra:scene "A tense dinner at the manor"
> [Identifies characters from context, loads scene — enters play loop]

/narra:scene
> [Asks which characters to include, then launches]
```
