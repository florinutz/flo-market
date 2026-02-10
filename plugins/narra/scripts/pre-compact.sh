#!/usr/bin/env bash
set -euo pipefail

# PreCompact curator: preserve narrative context before compaction
echo "[Narra Context Preservation]"
echo "Key narra commands available: /narra:status, /narra:search, /narra:dossier, /narra:prep"
echo "Use mcp__narra__session(operation='get_context') to restore entity awareness after compaction."

# If onboarding exists, inject key facts
if [ -f ".narra/onboarding.json" ] && command -v python3 &>/dev/null; then
  python3 -c "
import json
try:
    with open('.narra/onboarding.json') as f:
        data = json.load(f)
    hierarchy = data.get('character_hierarchy', [])
    if hierarchy:
        names = ', '.join(c.get('id','') for c in hierarchy[:5])
        print(f'Key characters: {names}')
    explored = data.get('explored_entities', [])
    if explored:
        print(f'Previously explored: {len(explored)} entities')
except:
    pass
" 2>/dev/null
fi
