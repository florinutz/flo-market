---
name: narra:export
description: Export world data to JSON for backup or migration
---

# Export World

Export the entire world state to a JSON file for backup or migration.

## Usage

/narra:export [output_path]
/narra:export --import <input_path>

## Export

Exports all world data to JSON:
- Characters (with psychology)
- Locations (with hierarchy)
- Events (with ordering)
- Scenes (with associations)
- Relationships (all types)
- Knowledge states (with provenance)
- Session state (pinned, recent)

Default output: `./narra-export-{timestamp}.json`

## Import

Imports world data from a JSON export file.

**Warning**: Import replaces all existing data. Consider backing up first.

## Implementation

Use the export_world MCP tool with the output path.

## Example

```
/narra:export
> Exported to: ./narra-export-2026-01-30.json
> - 15 characters
> - 8 locations
> - 23 events
> - 12 scenes

/narra:export ~/backups/world.json
> Exported to: /Users/florin/backups/world.json
```
