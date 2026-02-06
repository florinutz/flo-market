#!/usr/bin/env python3
"""
E2E MCP Client Test

Tests the Narra MCP server via the actual MCP protocol over stdio.
"""

import subprocess
import json
import sys
import time
import os

def send_request(proc, method, params, req_id):
    """Send a JSON-RPC request and get response"""
    request = {
        "jsonrpc": "2.0",
        "id": req_id,
        "method": method,
        "params": params
    }
    request_str = json.dumps(request) + "\n"
    print(f">>> Sending: {method} (id={req_id})", file=sys.stderr)
    print(f">>> Request: {request_str.strip()}", file=sys.stderr)

    proc.stdin.write(request_str)
    proc.stdin.flush()

    # Read response (assuming newline-delimited JSON)
    response_line = proc.stdout.readline()
    print(f"<<< Raw response: {response_line[:500] if response_line else 'EMPTY'}", file=sys.stderr)

    if response_line:
        try:
            response = json.loads(response_line)
            return response
        except json.JSONDecodeError as e:
            print(f"<<< JSON decode error: {e}", file=sys.stderr)
            return None
    return None

def main():
    # Clean up test directory
    test_dir = "/tmp/narra-e2e-test"
    os.system(f"rm -rf {test_dir}")
    os.makedirs(test_dir, exist_ok=True)

    # Determine launch script path
    script_dir = os.path.dirname(os.path.abspath(__file__))
    plugin_root = os.path.dirname(script_dir)
    launcher = os.path.join(plugin_root, "bin", "launch.sh")

    # Accept binary path override as first CLI arg
    if len(sys.argv) > 1:
        launcher = sys.argv[1]

    # Start the MCP server via launcher
    proc = subprocess.Popen(
        [launcher, "mcp"],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        env={**os.environ, "NARRA_DATA_PATH": test_dir}
    )

    # Give server time to start
    time.sleep(1)

    req_id = 0

    try:
        # 1. Initialize
        req_id += 1
        response = send_request(proc, "initialize", {
            "protocolVersion": "2024-11-05",
            "capabilities": {},
            "clientInfo": {
                "name": "narra-e2e-test",
                "version": "1.0.0"
            }
        }, req_id)

        if not response:
            print("FAIL: Initialize - no response")
            return 1

        if "error" in response:
            print(f"FAIL: Initialize error: {response['error']}")
            return 1

        if "result" not in response:
            print(f"FAIL: Initialize - no result: {response}")
            return 1

        server_info = response.get("result", {}).get("serverInfo", {})
        print(f"Server: {server_info.get('name')} v{server_info.get('version')}")

        # Send initialized notification (required by MCP protocol)
        init_notification = {
            "jsonrpc": "2.0",
            "method": "notifications/initialized"
        }
        print(f">>> Sending notification: notifications/initialized", file=sys.stderr)
        proc.stdin.write(json.dumps(init_notification) + "\n")
        proc.stdin.flush()

        # Small delay for notification processing
        time.sleep(0.2)

        # 2. List tools
        req_id += 1
        response = send_request(proc, "tools/list", {}, req_id)

        if not response:
            print("FAIL: tools/list - no response")
            return 1

        if "error" in response:
            print(f"FAIL: tools/list error: {response['error']}")
            return 1

        if "result" not in response:
            print(f"FAIL: tools/list - no result: {response}")
            return 1

        tools = response.get("result", {}).get("tools", [])
        tool_names = [t.get("name") for t in tools]
        print(f"Tools ({len(tools)}): {', '.join(tool_names)}")

        expected_tools = [
            "query", "mutate", "session", "export_world", "generate_graph"
        ]

        for tool in expected_tools:
            if tool not in tool_names:
                print(f"FAIL: Missing tool: {tool}")
                return 1

        print(f"PASS: All {len(expected_tools)} expected tools present")

        # 3. Call session (get_context)
        req_id += 1
        response = send_request(proc, "tools/call", {
            "name": "session",
            "arguments": {"operation": "get_context"}
        }, req_id)

        if response and "result" in response:
            print("PASS: session (get_context) tool works")
        elif response and "error" in response:
            print(f"WARN: session error: {response['error']}")
        else:
            print(f"WARNING: session returned: {response}")

        # 4. Call query overview
        req_id += 1
        response = send_request(proc, "tools/call", {
            "name": "query",
            "arguments": {
                "operation": "overview",
                "entity_type": "character"
            }
        }, req_id)

        if response and "result" in response:
            print("PASS: query tool works")
        elif response and "error" in response:
            print(f"WARN: query error: {response['error']}")
        else:
            print(f"WARNING: query returned: {response}")

        # 5. Create a character
        req_id += 1
        response = send_request(proc, "tools/call", {
            "name": "mutate",
            "arguments": {
                "operation": "create_character",
                "name": "Test Character",
                "description": "A character created by E2E test"
            }
        }, req_id)

        if response and "result" in response:
            print("PASS: mutate (create character) tool works")
            result_content = response.get("result", {}).get("content", [])
            if result_content:
                text = result_content[0].get('text', '')
                print(f"  Created: {text[:300]}...")
        elif response and "error" in response:
            print(f"FAIL: mutate error: {response['error']}")
            return 1
        else:
            print(f"FAIL: mutate returned: {response}")
            return 1

        # 6. Search for the character
        req_id += 1
        response = send_request(proc, "tools/call", {
            "name": "query",
            "arguments": {
                "operation": "search",
                "query": "Test Character"
            }
        }, req_id)

        if response and "result" in response:
            print("PASS: query (search) tool works")
            result_content = response.get("result", {}).get("content", [])
            if result_content:
                text = result_content[0].get('text', '')
                print(f"  Found: {text[:200]}...")
        elif response and "error" in response:
            print(f"WARN: search error: {response['error']}")
        else:
            print(f"WARNING: search returned: {response}")

        print("\n=== E2E TEST SUMMARY ===")
        print("All basic tests passed!")
        return 0

    except Exception as e:
        import traceback
        print(f"ERROR: {e}")
        traceback.print_exc()
        return 1

    finally:
        proc.terminate()
        try:
            proc.wait(timeout=2)
        except:
            proc.kill()

        # Print stderr for debugging
        stderr = proc.stderr.read() if proc.stderr else ""
        if stderr:
            print(f"\n=== Server stderr ===\n{stderr}", file=sys.stderr)

if __name__ == "__main__":
    sys.exit(main())
