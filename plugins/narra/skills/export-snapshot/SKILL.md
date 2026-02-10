---
description: Export world data and generate relationship graphs for backup or sharing
user_invocable: true
args:
  - name: path
    description: Output directory path (default: current directory)
    required: false
---

# Export Snapshot

Export the full world state and generate visual relationship graphs.

<instructions>

Export the narrative world to files.

### Step 1: Export world data
```
mcp__narra__export_world()
```

Report the output path and entity counts.

### Step 2: Generate relationship graph
```
mcp__narra__generate_graph()
```

Report the graph file location.

### Step 3: Summary

Format as:

```
## World Snapshot Exported

### Data Export
Path: [file path]
Contents: N characters, N locations, N events, N scenes, N relationships

### Relationship Graph
Path: [graph file path]
Format: Mermaid (.mmd)

### Next Steps
- View graph: paste .mmd contents into a Mermaid renderer
- Re-import: use mutate(operation="import_yaml", file_path="...") to restore
- Share: the YAML file is self-contained and re-importable
```

</instructions>
