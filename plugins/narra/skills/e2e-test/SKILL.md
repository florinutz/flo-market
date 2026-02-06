---
description: Run end-to-end MCP protocol tests against the Narra server
user_invocable: true
---

# E2E Test

Run end-to-end tests against the Narra MCP server to verify it works correctly.

## What This Tests

1. **MCP Protocol**: Initialize handshake, tool listing, tool calls
2. **All 5 Tools**: Verifies each tool is registered and callable
3. **Database Operations**: Creates entities, searches, queries
4. **Schema Application**: Confirms schema is applied on fresh installs

## How to Run

<instructions>

### Step 1: Ensure binary is available

```bash
bash ${CLAUDE_PLUGIN_ROOT}/bin/launch.sh --version
```

This will auto-download the binary on first run.

### Step 2: Run the E2E test

```bash
cd ${CLAUDE_PLUGIN_ROOT}
python3 scripts/e2e_test.py
```

### Expected Output

```
Server: narra v0.1.0
Tools (5): query, mutate, session, export_world, generate_graph
PASS: All 5 expected tools present
PASS: session (get_context) tool works
PASS: query tool works
PASS: mutate (create character) tool works
PASS: query (search) tool works

=== E2E TEST SUMMARY ===
All basic tests passed!
```

### Step 3: Report results

Tell the user:
- Whether all tests passed
- Any failures with error messages
- The server stderr output if there were issues

</instructions>

## Troubleshooting

### "missing field `created_at`" or "no suitable index"
The schema wasn't applied. Check that `apply_schema()` is called during initialization.

### Server doesn't respond
Check if the binary exists at `bin/narra` and run `bash bin/launch.sh --version` to re-download if needed.

### Python errors
Ensure Python 3 is installed and the script has execute permissions.
