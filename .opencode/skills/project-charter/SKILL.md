---
name: project-charter
description: Bootstrap a new project in this workspace — scaffold the folder from projects/_template, write its charter in PROJECT.md, create the matching ClickUp folder/lists, and register IDs in WORKSPACE.md. Use when the user starts, charters, or onboards a new project.
---
# project-charter

Turn "we have a new project" into a fully registered project.

## Procedure

1. **Interview first.** Before creating anything, ask the user for anything
   missing: project name, one-line purpose, the outcome that defines
   "done", target dates, and who is involved. Offer a sensible folder name
   (kebab or Title-Case, no spaces) for approval.
2. **Scaffold the folder.** Copy `projects/_template/` to
   `projects/<Project>/` (meetings/, docs/, archive/, DECISIONS.md,
   PROJECT.md). Never modify `_template` itself.
3. **Write the charter** in `projects/<Project>/PROJECT.md`:
   - Outcome / charter: what "done" looks like, verifiable.
   - Goals & success criteria as checkboxes.
   - Milestones table with target dates (even rough ones).
   - Status: `Active — just chartered`.
4. **Create ClickUp structure.** Confirm with the user before creating
   anything in ClickUp. Follow the workspace convention (one ClickUp
   **folder** per project inside the workspace's space, lists per work
   stream — see `WORKSPACE.md`). Record the new IDs.
5. **Register everywhere.**
   - `WORKSPACE.md`: add a row to the ClickUp ID map and to the portfolio
     register.
   - `PROJECT.md`: fill the ClickUp IDs section.
6. **Seed tasks.** Offer to break the first milestone into ClickUp tasks
   with owners and dates. Do it if the user agrees.
7. **Report.** List what was created (folder, files, ClickUp IDs, tasks).

## Rules

- Get folder name and ClickUp structure approved before creating.
- IDs only ever land in files after they exist in ClickUp.
