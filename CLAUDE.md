# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Flo Marketplace — a Claude Code plugin marketplace containing plugins that are installed via `/plugin marketplace add florinutz/flo-marketplace`. Each plugin lives under `plugins/<name>/` and follows the Claude Code plugin structure.

## Repository Structure

```
.claude-plugin/marketplace.json   # Marketplace manifest: lists available plugins
plugins/
  narra/                          # Narrative intelligence engine plugin
    .claude-plugin/plugin.json    # Plugin manifest (name, version, MCP server config)
    bin/launch.sh                 # Auto-downloads narra binary from GitHub releases
    bin/narra                     # Binary (gitignored, downloaded at runtime)
    commands/                     # Slash commands (export, pin, status)
    skills/                       # Skills (e2e-test, self-test, test-workflow, validate)
    hooks/hooks.json              # SessionStart hook
    scripts/e2e_test.py           # MCP protocol E2E test
```

## Architecture

**Marketplace manifest** (`.claude-plugin/marketplace.json`): Registers plugins with name, source path, and description. Adding a new plugin requires an entry here.

**Plugin anatomy** (using `narra` as the example):
- **MCP Server**: The core is a Rust binary (`narra`) that speaks MCP JSON-RPC over stdio. The binary is not checked in — `bin/launch.sh` auto-downloads the correct platform binary from GitHub releases (`florinutz/narra`), with version pinned in the script (`NARRA_VERSION`).
- **Commands** (`commands/*.md`): Slash commands with YAML frontmatter (`name`, `description`) and markdown body defining usage/behavior.
- **Skills** (`skills/*/SKILL.md`): More complex workflows with YAML frontmatter (`description`, `user_invocable`, optional `args`) and `<instructions>` blocks containing step-by-step implementation guidance.
- **Hooks** (`hooks/hooks.json`): Event-driven automation (e.g., SessionStart prints available MCP tools).

**Narra MCP tools**: `query`, `mutate`, `session`, `export_world`, `generate_graph`. These operate on narrative entities (characters, locations, events, scenes, relationships, knowledge states).

## Testing

E2E test (tests MCP protocol, tool listing, database operations):
```bash
cd plugins/narra && python3 scripts/e2e_test.py
```

The test starts the MCP server, performs a JSON-RPC handshake, and exercises each tool. Uses `/tmp/narra-e2e-test` for test data.

## Adding a New Plugin

1. Create `plugins/<name>/` with the standard structure (`.claude-plugin/plugin.json`, commands, skills, hooks as needed)
2. Add entry to `.claude-plugin/marketplace.json` under the `plugins` array
