---
description: Test a complete fiction writing workflow with Narra (create characters, relationships, knowledge)
user_invocable: true
args:
  - name: clean
    description: Start with fresh data (true/false)
    required: false
    default: "true"
---

# Test Complete Workflow

Run through a complete fiction writing workflow to verify all Narra capabilities work together.

## What This Tests

1. **Character Creation**: Multiple characters with traits and backgrounds
2. **Location Creation**: Settings for the story
3. **Relationships**: Characters knowing and perceiving each other
4. **Knowledge System**: What characters know and how they learned it
5. **Session Continuity**: Context restoration between sessions
6. **Search & Query**: Finding entities by various criteria

<instructions>

### Step 1: Setup

If `{{clean}}` is "true":
```bash
rm -rf /tmp/narra-workflow-test
mkdir -p /tmp/narra-workflow-test
```

### Step 2: Run workflow via E2E test

Create an extended E2E test that exercises the full workflow:

```python
#!/usr/bin/env python3
"""Extended workflow test for Narra"""

import subprocess
import json
import sys
import time
import os

def send_request(proc, method, params, req_id):
    request = {"jsonrpc": "2.0", "id": req_id, "method": method, "params": params}
    proc.stdin.write(json.dumps(request) + "\n")
    proc.stdin.flush()
    response_line = proc.stdout.readline()
    return json.loads(response_line) if response_line else None

def call_tool(proc, name, arguments, req_id):
    return send_request(proc, "tools/call", {"name": name, "arguments": arguments}, req_id)

def main():
    test_dir = "/tmp/narra-workflow-test"
    os.makedirs(test_dir, exist_ok=True)

    plugin_root = os.environ.get("CLAUDE_PLUGIN_ROOT", os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

    proc = subprocess.Popen(
        [os.path.join(plugin_root, "bin", "launch.sh"), "mcp"],
        stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
        text=True, env={**os.environ, "NARRA_DATA_PATH": test_dir}
    )
    time.sleep(1)

    req_id = 0
    results = []

    # Initialize
    req_id += 1
    send_request(proc, "initialize", {
        "protocolVersion": "2024-11-05", "capabilities": {},
        "clientInfo": {"name": "workflow-test", "version": "1.0"}
    }, req_id)
    proc.stdin.write('{"jsonrpc":"2.0","method":"notifications/initialized"}\n')
    proc.stdin.flush()

    # Test 1: Create protagonist
    req_id += 1
    r = call_tool(proc, "mutate", {
        "operation": "create_character",
        "name": "Elena Martinez",
        "role": "protagonist",
        "description": "A former detective haunted by an unsolved case"
    }, req_id)
    results.append(("Create protagonist", r and "result" in r and not r.get("result", {}).get("isError")))

    # Test 2: Create antagonist
    req_id += 1
    r = call_tool(proc, "mutate", {
        "operation": "create_character",
        "name": "Victor Shaw",
        "role": "antagonist",
        "description": "A charismatic businessman with dark secrets"
    }, req_id)
    results.append(("Create antagonist", r and "result" in r and not r.get("result", {}).get("isError")))

    # Test 3: Create location
    req_id += 1
    r = call_tool(proc, "mutate", {
        "operation": "create_location",
        "name": "The Midnight Club",
        "description": "An exclusive speakeasy where the city's elite gather"
    }, req_id)
    results.append(("Create location", r and "result" in r and not r.get("result", {}).get("isError")))

    # Test 4: Query all characters
    req_id += 1
    r = call_tool(proc, "query", {"operation": "overview", "entity_type": "character"}, req_id)
    content_text = ""
    if r and "result" in r:
        result_content = r.get("result", {}).get("content", [])
        if result_content:
            content_text = result_content[0].get("text", "")
    results.append(("Query characters", "Elena" in content_text and "Victor" in content_text))

    # Test 5: Search by description
    req_id += 1
    r = call_tool(proc, "query", {"operation": "search", "query": "detective"}, req_id)
    content_text = ""
    if r and "result" in r:
        result_content = r.get("result", {}).get("content", [])
        if result_content:
            content_text = result_content[0].get("text", "")
    results.append(("Search by description", "Elena" in content_text))

    # Test 6: Session context
    req_id += 1
    r = call_tool(proc, "session", {"operation": "get_context"}, req_id)
    results.append(("Session context", r and "result" in r))

    # Test 7: Generate graph
    req_id += 1
    r = call_tool(proc, "generate_graph", {"scope": "full"}, req_id)
    results.append(("Generate graph", r and "result" in r))

    proc.terminate()

    # Report
    print("\n=== WORKFLOW TEST RESULTS ===")
    passed = sum(1 for _, ok in results if ok)
    for name, ok in results:
        status = "PASS" if ok else "FAIL"
        print(f"  [{status}] {name}")
    print(f"\nTotal: {passed}/{len(results)} tests passed")

    return 0 if passed == len(results) else 1

if __name__ == "__main__":
    sys.exit(main())
```

Save this to a temp file and run it, or run the steps manually using the MCP tools.

### Step 3: Report results

Report which workflow steps passed/failed and any issues encountered.

</instructions>
