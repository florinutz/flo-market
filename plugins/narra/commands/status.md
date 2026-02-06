---
name: narra:status
description: Show world overview and session status
---

# Narra Status

Show the current state of the narrative world and session.

## Usage

/narra:status

## What It Shows

- **World Overview**: Character, location, event, and scene counts
- **Hot Entities**: Recently accessed entities (top 10)
- **Pinned Entities**: Explicitly pinned for quick access
- **Pending Decisions**: Deferred impact analysis decisions
- **Session Info**: Last session time, data path

## Implementation

Use the query tool with operation "overview" to get entity counts.
Use the session tool with get_context operation to get hot entities and pending decisions.

Present results in a clean summary format.
