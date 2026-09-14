---
name: action-items
description: Extract commitments and action items from meeting notes or conversation text, then create or update matching ClickUp tasks with owner, due date, and source reference. Use when the user shares meeting notes, says "extract action items", or asks to log follow-ups.
---
# action-items

No orphan commitments: anything a person agreed to becomes a tracked task.

## Procedure

1. **Identify the source.** A file the user points at (typically
   `projects/<Project>/meetings/*.md`), text pasted into the conversation,
   or the current conversation itself.
2. **If the source is a pasted/verbal meeting, save it first** as
   `projects/<Project>/meetings/YYYY-MM-DD-<topic>.md` (ask which project
   if unclear). Include attendees and raw notes.
3. **Extract every commitment**: explicit action items first, then implied
   ones ("I'll send…", "we should…", "next step is…"). For each, capture:
   - Action (verb-first, outcome-oriented, one sentence).
   - Owner (who committed; ask if unstated).
   - Due date (ask if unstated; never invent hard dates).
   - Source (file + heading or conversation date).
4. **Deduplicate against ClickUp.** Search the project's tasks for
   existing matches. Update (add due date, assignee, note) rather than
   create twins.
5. **Create new tasks** in the correct list (IDs from `WORKSPACE.md` /
   `PROJECT.md`), with the action as title, context + source link in the
   description, priority only if the user indicated one.
6. **Annotate the notes**: append an "## Action items" section to the
   meeting file listing task → ClickUp task ID, so notes stay traceable
   to tasks.
7. **Report**: table of items — action, owner, due, task ID, created vs
   updated. Flag anything ambiguous you had to interpret.

## Rules

- Never silently assign a due date or owner that wasn't stated — ask.
- One commitment = one task; split compound items.
