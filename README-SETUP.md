# README — Setup & Porting Guide

This workspace is a **portable skeleton** for executive project management
with OpenCode + ClickUp. It is self-contained: everything it needs lives in
this folder, with no absolute paths.

## First run (this copy)

1. `git init` — already done. Commit whenever you like; the repo also makes
   OpenCode discover this workspace's config from any depth inside it.
2. Authenticate ClickUp (one time, per machine):
   ```
   opencode mcp auth clickup
   ```
   A browser opens → authorize ClickUp → tokens are stored by OpenCode.
3. Fill the **ClickUp ID map** in `WORKSPACE.md` (team ID, space ID). Ask
   the project-manager agent to do it: "discover our ClickUp structure and
   fill in WORKSPACE.md".
4. Create your first project: "charter a new project called X" (uses the
   `project-charter` skill).
5. Verify: `opencode debug config` in this folder should show
   `project-manager` as default agent and the `clickup` MCP server.

## Copying this skeleton elsewhere

### Same ClickUp account

Copy the whole folder (without `.git`), then in the copy:

```
git init
```

Done — `opencode mcp auth clickup` is not needed again (tokens are stored
globally per server name).

### Different ClickUp account (important)

OpenCode stores MCP OAuth tokens **globally, keyed by server name**. Two
workspaces using different ClickUp accounts must use **different server
names**, or they will fight over one token. In the copy:

1. In `opencode.json`: rename the key `"clickup"` to something unique,
   e.g. `"clickup-personal"` (keep the same URL).
2. Update the name in: `WORKSPACE.md` ("How this workspace runs"), and any
   references in `.opencode/agents/project-manager.md` (search for
   `clickup_` permission keys — the glob stays the same since it matches the
   new prefix automatically).
3. Authenticate: `opencode mcp auth clickup-personal`.
4. `git init`, fill the new account's IDs in `WORKSPACE.md`.

## What NOT to change

- `AGENTS.md` non-negotiables (IDs, confirmations, no-coding) — these are
  the safety rails.
- The `_template` folder — copy it per project, never work inside it.
