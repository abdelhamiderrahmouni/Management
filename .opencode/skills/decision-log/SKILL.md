---
name: decision-log
description: Record a decision with its context, alternatives considered, and consequences in the project's DECISIONS.md. Use when the user makes or asks to log a decision, or when a report reveals a decision that should be captured.
---
# decision-log

Decisions are the most valuable project history. Capture them while fresh.

## Procedure

1. **Identify the project** (from context or ask). Never log decisions to
   the wrong folder — when in doubt, ask.
2. **Gather the decision record.** From the conversation, or by asking:
   - **Decision**: one sentence, in the imperative/past ("We use X").
   - **Context**: why this came up; what constraint or event forced it.
   - **Alternatives considered**: what else was on the table and why it
     lost.
   - **Consequences / implications**: what this commits us to, enables,
     or rules out.
   - **Date** and (optionally) who decided.
3. **Append to `projects/<Project>/DECISIONS.md`** in the table, next
   number in sequence. Never reorder or rewrite past entries — decisions
   are immutable history; corrections become new entries.
4. **Link consequences to work.** If the decision spawns tasks, milestones,
   or invalidates existing ClickUp tasks, say so and offer to make those
   changes (create tasks, update `PROJECT.md`).
5. **Confirm**: show the logged entry to the user in one line.

## Rules

- A decision without a stated alternative is still loggable — write
  "none considered" rather than inventing options.
- Distinguish *decisions* (choices made) from *facts* (things that
  happened to us). Only the former go in DECISIONS.md.
