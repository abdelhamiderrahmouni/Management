# Workspace Rules — Management

This is an **executive project management workspace**. It manages goals, plans,
priorities, milestones, decisions, and follow-ups — the management layer above
any implementation. It is not a codebase.

## What lives here

- `WORKSPACE.md` — portfolio index + ClickUp ID map. **Read it before any
  ClickUp operation.** Keep it current whenever projects or ClickUp structure
  change.
- `projects/<Project>/` — one folder per project, containing only files
  relevant to that project (`PROJECT.md`, `DECISIONS.md`, `meetings/`,
  `docs/`, `archive/`).
- `projects/_template/` — starter folder for new projects. Copy it, never
  work inside it.
- `archive/` — closed projects. Move a project folder here only after
  confirming with the user.

## Division of truth

| Domain | Source of truth |
|---|---|
| Tasks, statuses, due dates, assignees, priorities | **ClickUp** (via the `clickup` MCP server) |
| Goals, decisions, context, meeting history, documents | **Local files** in `projects/<Project>/` |
| Executive summary bridging both | `projects/<Project>/PROJECT.md` |

## Non-negotiables

1. **Never guess ClickUp IDs.** Get them from `WORKSPACE.md`. If the map is
   missing or stale, discover them via the ClickUp API (`get_workspaces` →
   `get_spaces` → `get_lists`) and update `WORKSPACE.md` first.
2. **Destructive actions require explicit confirmation** — deleting tasks,
   closing/canceling items, moving folders, deleting or overwriting files
   outside a normal edit.
3. **No coding.** Never write or refactor code, run build tools, or perform
   git operations beyond read-only inspection. A coding need is captured as a
   ClickUp task, not performed here.
4. **Projects stay self-contained.** Nothing project-specific goes anywhere
   except inside that project's folder (or its ClickUp tasks).
5. **Status stays honest.** When reporting, distinguish what was verified
   (read from ClickUp/files) from what is assumed or remembered.
