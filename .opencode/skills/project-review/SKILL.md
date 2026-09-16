---
name: project-review
description: Reconcile local project files against live ClickUp state, flag overdue/blocked/unowned/stale items, propose reprioritization, and update PROJECT.md and the WORKSPACE.md register. Use for weekly reviews, per-project deep checks, or when the user asks "review project X" or "where do things stand".
---
# project-review

The reconciliation loop between the two sources of truth. Run per project
(`/review <Project>`) or across the whole portfolio (`/weekly`).

## Procedure

1. **Load context.** Read `WORKSPACE.md`, then the target project's
   `PROJECT.md` (or every project's, for a portfolio review).
2. **Pull live state from ClickUp** using the IDs in `WORKSPACE.md` /
   `PROJECT.md`. Never review from memory. For each project capture:
   open tasks by status, overdue items, tasks without assignee or due
   date, upcoming milestones, recently closed work.
3. **Reconcile files ↔ ClickUp.**
   - Does `PROJECT.md`'s status section match reality? Update it.
   - Are completed tasks reflected in milestones? Move them along.
   - Any drift (task done in ClickUp but listed as next step in files, or
     the reverse)? Fix the files; if genuinely ambiguous, ask.
4. **Flag** (portfolio-wide, and per project where relevant):
   - Overdue and at-risk tasks.
   - Blocked tasks and what blocks them.
   - Unowned or undated commitments.
   - Decisions still marked `Proposed` in `DECISIONS.md`.
   - Stale projects (no movement in ~2 weeks) — say so bluntly.
   - Cross-project collisions: shared deadlines, same people, competing
     priorities.
5. **Propose, don't unilaterally reorder.** Suggest priority changes as a
   short list ("do these 3, defer these 2 because …"). Apply to ClickUp
   only after the user agrees.
6. **Update records.** Set "Last reviewed" to today in the `WORKSPACE.md`
   register row for each reviewed project.
7. **Report** in the standing format: Needs your attention → Status →
   Changes I made.

## Rules

- Verified facts only in status lines; label anything assumed.
- A review that changes nothing still gets reported — "no movement, here's
  what that might mean" is a finding.
