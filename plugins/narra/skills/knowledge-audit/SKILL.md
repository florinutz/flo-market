---
description: Audit character knowledge — find gaps, false beliefs, and dramatic irony opportunities
user_invocable: true
args:
  - name: scope
    description: Character name or "all" for full audit
    required: false
    default: all
---

# Knowledge Audit

Audit what characters know, believe, and don't know — finding opportunities for dramatic irony.

<instructions>

Run a knowledge audit for scope: {{scope}}

### Step 1: Knowledge conflicts
Find cases where characters hold contradictory beliefs:
```
mcp__narra__query(operation="knowledge_conflicts")
```

### Step 2: Knowledge asymmetries
Find what some characters know that others don't:
```
mcp__narra__query(operation="knowledge_asymmetries")
```

### Step 3: Dramatic irony report
If a specific character was named in the scope, focus on them:
```
mcp__narra__query(operation="dramatic_irony_report", character_id="<id>")
```
If scope is "all", run for the most central characters.

### Step 4: Knowledge gap analysis
```
mcp__narra__query(operation="knowledge_gap_analysis")
```

### Step 5: Present audit report

Format as:

```
## Knowledge Audit

### False Beliefs
[Characters who believe things that aren't true]

### Knowledge Asymmetries
[Who knows what that others don't — organized by dramatic potential]

### Dramatic Irony Opportunities
[Situations where the reader/audience knows more than characters]

### Knowledge Gaps
[Important things that no character knows yet]
```

Highlight the most dramatically interesting findings. Suggest how knowledge reveals could create tension.

</instructions>
