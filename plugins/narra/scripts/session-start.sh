#!/usr/bin/env bash
set -euo pipefail

# SessionStart curator: detect narra world and inject context
# Output goes to LLM as session context

ONBOARDING_FILE=".narra/onboarding.json"

# Check if .narra/ exists in project
if [ ! -d ".narra" ]; then
  exit 0  # No narra world, skip silently
fi

echo "[Narra] Narrative world detected."
echo ""
echo "Available tools: query (40 ops), mutate (25 ops), session, export_world, generate_graph"
echo "Commands: /narra:explore, /narra:status, /narra:prep, /narra:audit, /narra:build, /narra:search, /narra:dossier, /narra:graph"
echo ""

# Check onboarding state
if [ ! -f "$ONBOARDING_FILE" ]; then
  echo "⚡ New world — run /narra:explore to discover characters, tensions, and story structure."
else
  # Check staleness
  if command -v python3 &>/dev/null; then
    STALENESS=$(python3 -c "
import json, datetime, sys
try:
    with open('$ONBOARDING_FILE') as f:
        data = json.load(f)
    last = datetime.datetime.fromisoformat(data.get('last_explored', '2000-01-01'))
    age = (datetime.datetime.now(datetime.timezone.utc) - last).total_seconds() / 86400
    if age > 7:
        print('stale')
    elif age > 1:
        print('medium')
    else:
        print('fresh')
except:
    print('stale')
" 2>/dev/null || echo "stale")
  else
    STALENESS="stale"
  fi

  case "$STALENESS" in
    fresh)
      # Inject lightweight summary from onboarding JSON
      python3 -c "
import json
try:
    with open('$ONBOARDING_FILE') as f:
        data = json.load(f)
    snap = data.get('world_snapshot', {})
    chars = snap.get('character_count', '?')
    events = snap.get('event_count', '?')
    locs = snap.get('location_count', '?')
    scenes = snap.get('scene_count', '?')
    print(f'World: {chars} characters, {events} events, {locs} locations, {scenes} scenes')
    hierarchy = data.get('character_hierarchy', [])
    if hierarchy:
        top = ', '.join(c.get('id','?') for c in hierarchy[:5])
        print(f'Key characters: {top}')
    tensions = data.get('tension_catalog', [])
    if tensions:
        print(f'Active tensions: {len(tensions)}')
except:
    pass
" 2>/dev/null
      ;;
    medium)
      echo "📊 World may have changed since last exploration (1-7 days ago)."
      echo "Run /narra:status for a quick update or /narra:explore for full re-discovery."
      ;;
    stale)
      echo "⚡ World exploration is stale (>7 days). Run /narra:explore to re-discover."
      ;;
  esac
fi
