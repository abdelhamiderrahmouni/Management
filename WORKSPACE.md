# WORKSPACE — Management

Purpose: executive management of employment projects — goals, planning,
priorities, milestones, decisions, and follow-ups.

## How this workspace runs

- Default agent: `project-manager` (Tab to switch).
- Skills: `project-charter`, `project-review`, `action-items`, `decision-log`.
- Commands: `/weekly` (portfolio review), `/focus` (today's attention
  report), `/inbox` (what changed in ClickUp).
- ClickUp connection: `clickup` MCP server → `https://mcp.clickup.com/mcp`
  (OAuth via `opencode mcp auth clickup`).

## ClickUp ID map

> Fill this after running `opencode mcp auth clickup`.
> Discover IDs with: `get_workspaces` → `get_spaces` (team_id) →
> `get_lists` (space_id). Paste IDs as strings — they are long.

- ClickUp team (workspace) ID: ``
- Space used by this workspace: `` (ID: ``)
- Convention: each project folder ↔ one ClickUp **folder**, with lists
  inside it per work stream.

| Project folder | ClickUp folder ID | ClickUp list IDs | Notes |
|---|---|---|---|
| _(none yet — add via `project-charter`)_ | | | |

## Portfolio register

> One row per project. Update the "Last reviewed" date on every
> `project-review` run.

| Project | One-line purpose | Status | Next milestone | Last reviewed |
|---|---|---|---|---|
| _(none yet)_ | | | | |

## Standing notes

- Review cadence: weekly (`/weekly`), quick check daily (`/focus`).
- Anything that needs the user's decision goes to `DECISIONS.md` in the
  project folder, and is surfaced in the next report.
