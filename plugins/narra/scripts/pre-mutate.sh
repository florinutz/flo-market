#!/usr/bin/env bash
set -euo pipefail

# PreToolUse guardian: warn about significant mutations
# Reads tool input from stdin (JSON)

INPUT=$(cat)

# Extract operation
OPERATION=$(echo "$INPUT" | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    params = data.get('tool_input', data.get('input', {}))
    print(params.get('operation', ''))
except:
    print('')
" 2>/dev/null || echo "")

case "$OPERATION" in
  delete)
    echo "⚠️  DELETE operation detected. This will permanently remove an entity and its relationships."
    ;;
  update)
    echo "ℹ️  Entity update in progress. Core field changes (name, role, wound) may affect arc tracking."
    ;;
  protect_entity|unprotect_entity)
    echo "🔒 Protection status change. Protected entities block cascading deletions."
    ;;
  import_yaml)
    echo "⚠️  YAML import will create/update many entities. Ensure the import file is correct."
    ;;
esac
