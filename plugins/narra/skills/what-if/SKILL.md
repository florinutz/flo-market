---
description: Explore hypothetical scenarios — what if a character learns something, dies, or changes allegiance?
user_invocable: true
args:
  - name: scenario
    description: The hypothetical scenario to explore
    required: true
---

# What If

Explore the ripple effects of hypothetical changes to the narrative world.

<instructions>

Analyze this hypothetical scenario: {{scenario}}

### Step 1: Parse the scenario
Identify:
- **What changes**: The core hypothetical event or revelation
- **Who's affected**: Primary entity/character involved
- **Type of change**: Knowledge reveal, death, betrayal, alliance shift, etc.

### Step 2: Run What-If analysis
```
mcp__narra__query(operation="what_if", scenario="{{scenario}}")
```

### Step 3: Analyze impact
Identify the primary entity affected and run impact analysis:
```
mcp__narra__query(operation="analyze_impact", changed_entity="<entity_id>", change_description="{{scenario}}")
```

### Step 4: Present analysis

Format as:

```
## What If: [scenario summary]

### Immediate Effects
[Direct consequences of the change]

### Ripple Effects
[Secondary and tertiary impacts, organized by severity]
- Critical: [effects that fundamentally change the story]
- Significant: [major but manageable effects]
- Minor: [small adjustments needed]

### Affected Characters
[Who is impacted and how, with severity]

### Story Implications
[How this would change ongoing arcs, tensions, and themes]

### Protected Entities
[If any protected entities would be affected, flag them]
```

Be speculative but grounded — base analysis on actual relationship data and knowledge states in the world.

</instructions>
