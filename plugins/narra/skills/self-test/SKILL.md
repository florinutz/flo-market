---
description: Run self-tests using Claude Code programmatically to verify the plugin works end-to-end with a real LLM
user_invocable: true
args:
  - name: model
    description: Model to use (haiku, sonnet, opus)
    required: false
    default: haiku
---

# Self-Test with Claude

Run automated tests using Claude Code programmatically to verify the Narra plugin works correctly with a real LLM interaction.

## What This Tests

1. **Plugin Loading**: Claude Code loads the Narra MCP server
2. **Tool Discovery**: Claude can see and use Narra tools
3. **Real Workflows**: Create characters, query world state, search
4. **Response Quality**: Claude interprets tool responses correctly

## Prerequisites

- Claude Code CLI installed (`claude --version`)
- API credits available
- Narra binary available (auto-downloads on first run)

<instructions>

### Step 1: Clear test data

```bash
rm -rf /tmp/narra-self-test
mkdir -p /tmp/narra-self-test
```

### Step 2: Run self-test scenarios

Run each test scenario using Claude programmatically. Use the model specified by the user (default: haiku).

**Test 1: Tool Discovery**
```bash
cd /tmp/narra-self-test
NARRA_DATA_PATH=/tmp/narra-self-test claude -p "List all the Narra tools available to you. Just list their names, one per line." \
  --model {{model}} \
  --output-format json \
  --allowedTools "mcp__narra__*"
```

Expected: Response should list the 5 tools: query, mutate, session, export_world, generate_graph.

**Test 2: Create Character**
```bash
cd /tmp/narra-self-test
NARRA_DATA_PATH=/tmp/narra-self-test claude -p "Use Narra to create a character named 'Alice' who is a detective with a mysterious past." \
  --model {{model}} \
  --output-format json \
  --allowedTools "mcp__narra__*"
```

Expected: Character created successfully with ID.

**Test 3: Query World**
```bash
cd /tmp/narra-self-test
NARRA_DATA_PATH=/tmp/narra-self-test claude -p "Use Narra to show me all characters in my world." \
  --model {{model}} \
  --output-format json \
  --allowedTools "mcp__narra__*"
```

Expected: Should show Alice.

**Test 4: Search**
```bash
cd /tmp/narra-self-test
NARRA_DATA_PATH=/tmp/narra-self-test claude -p "Use Narra to search for 'detective'." \
  --model {{model}} \
  --output-format json \
  --allowedTools "mcp__narra__*"
```

Expected: Should find Alice.

### Step 3: Report results

Parse the JSON output from each test and report:
- Which tests passed/failed
- Any error messages
- Total API cost (from usage field in JSON)

</instructions>

## Troubleshooting

### "Credit balance is too low"
Add credits to your Anthropic account or use a different API key.

### "Tool not found"
The Narra plugin may not be loaded. Check that `.claude-plugin/plugin.json` exists and the binary is available.

### Timeout errors
The MCP server may be slow to start. Try increasing timeout or running tests individually.
