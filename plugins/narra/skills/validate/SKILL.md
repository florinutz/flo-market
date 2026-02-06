---
description: Quick validation that the Narra plugin is properly configured and working
user_invocable: true
---

# Validate Plugin

Quick validation checks to ensure the Narra plugin is properly configured and ready to use.

<instructions>

Run these validation checks in order. Stop at the first failure and report the issue.

### Check 1: Binary exists

```bash
ls -la ${CLAUDE_PLUGIN_ROOT}/bin/narra
```

If missing: Run `bash ${CLAUDE_PLUGIN_ROOT}/bin/launch.sh --version` to trigger auto-download.

### Check 2: Plugin manifest exists

```bash
cat ${CLAUDE_PLUGIN_ROOT}/.claude-plugin/plugin.json
```

Should show plugin metadata with name "narra" and mcpServers config pointing to `launch.sh` with `["mcp"]` args.

### Check 3: Server starts

```bash
cd ${CLAUDE_PLUGIN_ROOT}
NARRA_DATA_PATH=/tmp/narra-validate-test ./bin/launch.sh mcp &
PID=$!
sleep 2
kill $PID 2>/dev/null
```

Check stderr output for:
- "Starting Narra MCP server"
- "Database connected"
- "Schema applied"
- "MCP server listening on stdio (5 tools)"

### Check 4: E2E protocol test

```bash
cd ${CLAUDE_PLUGIN_ROOT}
python3 scripts/e2e_test.py
```

Should show all tests passing.

### Report Summary

Report validation status:

```
Narra Plugin Validation
=======================
[x] Binary exists: bin/narra
[x] Plugin manifest: .claude-plugin/plugin.json valid
[x] Server starts: 5 tools registered
[x] E2E tests: All passed

Status: READY
```

Or if there are issues:

```
Narra Plugin Validation
=======================
[x] Binary exists
[ ] Server starts: FAILED - check build
...

Status: NOT READY
Action: <specific fix instructions>
```

</instructions>
