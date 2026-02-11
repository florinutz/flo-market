---
description: Play an interactive scene — write as your character or direct from above, with NPCs grounded in full narrative intelligence
user_invocable: true
args:
  - name: prompt
    description: Characters and/or narrative setup for the scene
    required: false
---

# Scene Play

Launch an interactive scene where characters come alive — filtered through their knowledge, perceptions, psychology, and voice.

<instructions>

Start an interactive scene session using the **scene-runner** agent.

{{#if prompt}}
Scene setup: {{prompt}}
{{/if}}

Launch the scene-runner agent via the Task tool. Pass the user's prompt (if provided) as the scene description. If no prompt was given, use AskUserQuestion to ask the user which characters should be in the scene and what the setup is.

The scene-runner agent handles everything from here: character loading, scene prep, play loop, and persistence.

## Quick Start

**Basic usage** — name characters and a situation:
```
scene-play alice bob "Alice arrives at the market"
```

**Prompt only** — let the system identify characters from context:
```
scene-play "A tense dinner at the manor"
```

**No arguments** — the agent will ask you what to set up:
```
scene-play
```

## Two Play Modes

### Writing Mode
You write dialogue and action as your chosen character. The agent plays all NPCs, responding through each character's unique knowledge, voice, and psychology. NPCs will never reference information they don't possess. They will lie, deflect, or reveal based on who they are.

### Director Mode
You give high-level direction ("escalate the tension," "Elena confronts Matei about the letter"). The agent generates the full exchange — dialogue, action, interiority — pausing at decision points to offer you choices about how the scene unfolds.

You choose your mode at scene start. You can switch between modes at any time.

## `>>` Sidebar Assist

Keep your scene text clean. Use the `>>` prefix for meta-requests — narrative analysis, suggestions, and structural guidance — without breaking the flow.

Examples:
```
>> What does Elena actually know right now?
>> Give me three ways Matei could respond to this
>> How's the pacing? Am I rushing?
>> What irony opportunities am I missing?
```

Assist responses appear in blockquotes or headed with **[Assist]**, separate from scene prose.

Three categories of assist, chosen based on context:
- **Narrative intelligence**: subtext, irony opportunities, knowledge asymmetries, perception gaps
- **Generative proposals**: dialogue options, beat suggestions, description drafts, NPC reactions
- **Structural guidance**: pacing, arc tracking, tension monitoring, scene shape

## Draft Persistence

Scenes play in a buffer. **Your world state is never modified during the scene.**

As the scene unfolds, the agent silently tracks every proposed change — new knowledge edges, perception shifts, relationship changes, arc movements, new events.

When the scene ends, you see a structured diff of everything that changed:

```
## Proposed World Changes

### New Knowledge
- Alice now knows: Bob was at the tower that night

### Perception Shifts
- Elena -> Matei: tension_level 4 -> 7

### Relationship Changes
- Elena <-> Matei: added "fractured trust" edge
```

You choose:
- **Accept All** — commit everything to the world state
- **Review Each** — walk through changes one by one, accepting or rejecting
- **Discard All** — throw away the buffer, no changes persist

This means you can experiment freely. Play a scene to see what happens, then discard it if you don't like the direction. Or accept the parts that worked and reject the rest.

</instructions>
