---
name: narra:pin
description: Pin or unpin an entity for persistent focus
---

# Pin Entity

Pin or unpin entities to keep them in your working context.

## Usage

/narra:pin <entity_name_or_id>
/narra:pin --unpin <entity_name_or_id>
/narra:pin --list

## Behavior

**Pin**: Adds entity to pinned list. Pinned entities:
- Always appear in session context
- Get priority in relevance scoring
- Persist across sessions

**Unpin**: Removes entity from pinned list.

**List**: Shows all currently pinned entities.

## Arguments

- `entity_name_or_id`: Entity name (e.g., "Alice") or full ID (e.g., "character:alice")
- `--unpin`: Unpin instead of pin
- `--list`: List all pinned entities

## Implementation

Use the session tool with pin_entity/unpin_entity operations for pin/unpin.

For --list, use the session tool with get_context operation and extract pinned entities.

## Example

```
/narra:pin Alice
> Pinned: character:alice

/narra:pin --list
> Pinned entities:
> - character:alice (Alice)
> - location:manor (The Manor)

/narra:pin --unpin Alice
> Unpinned: character:alice
```
