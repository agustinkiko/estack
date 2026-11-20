---
name: decisions
description: Use for a long or multi-phase run, or when a change settles a choice a future agent could undo. Also use when asked why something is the way it is. Keeps a local decision trail per run and durable entries in the repo's decisions file, and answers "why" from the record.
---

# Decisions

`<proof folder>` and `<decisions file>` come from the repo settings in
`core` rules.

Two records, with two lifetimes:

| Record | Where | Holds |
|---|---|---|
| Run trail | `<proof folder>/decisions.tsv`, ignored by git | each fork in one run, with its evidence |
| Decisions file | `<decisions file>`, committed | the few choices a future agent must not undo |

## Run trail

Keep one for a long or multi-phase run, or for work someone reviews
after stepping away.

1. Git must ignore `<proof folder>`. If
   `git check-ignore -q <proof folder>` fails, add the folder to
   `.git/info/exclude`.
2. Add each row with `scripts/log.sh` in this skill's folder:
   `scripts/log.sh <proof folder>/decisions.tsv <phase> <decision> <why> <evidence> <result>`.
   It stamps the time, writes the header on first use, keeps each cell
   on one line, and quotes cells a spreadsheet would run as a formula.
   - `why` is the reason in plain words, as you would tell a teammate.
   - `evidence` is a pointer: a commit, a `file:line`, a test run, or a
     PR. Never prose.
   - `result` is a state, such as `tests pass`, `reverted`, or `open`.
3. Log forks, finished units with their check result, reverts, and
   blockers. Skip routine steps.
4. Append only. A wrong row gets a new row that supersedes it.
5. A new run (a new chat, a pickup, or a replacement agent) that adds to
   a trail with rows starts with phase `start`. Its decision names the
   `ts` range of earlier rows it did not write. Its evidence names the
   run, such as the agent ID. Use phase `start` for nothing else.
6. **Audit before the report.** Walk this run's rows against what
   happened:
   - Each row maps to a real decision or action.
   - Each evidence pointer resolves and shows what the row claims.
   - A fork, pivot, or dropped approach that shaped the work but has no
     row is a gap. Add it.

   Fix the log, not the story: a wrong row gets a new row, never an edit.
7. **Fresh review.** Start a fresh agent with no chat history, on another
   model if your tool allows. Give it the trail. Ask it for rows with
   weak or missing evidence, checks claimed without proof, choices that
   look risky now, and gaps a quick read would miss. End the report with
   an `Attention` section: the reviewer's model on the first line, then
   each flag with its row. `No flags` is a valid answer. If your tool
   cannot start an agent, say so there.

The trail never goes in a commit. Copy the rows a reviewer needs into
the PR.

## Decisions file

### What goes in

Ask: could a future agent read the code and the git log, and undo this
by mistake? If yes, log it.

- A tradeoff, with the option you rejected.
- An outside quirk: a vendor limit, a platform bug, a billing block.
- A business rule or an owner's call that the code cannot show.

### What stays out

- A rule that a lint, type, schema, or test can enforce. Enforce it
  there instead, with `core:principle-encode-lessons-in-structure`.
- Facts that the code, the lock file, or the dependency list already
  show.
- Routine fixes.

### Entry format

Five lines at most:

```markdown
### D-012 · <area> · <the decision, in one line>
- Decided: <date>, by <who>. Source: <PR, ticket, or doc link>
- Why: <the constraint or evidence at the time>
- Rejected: <the other option, and why it lost>
- Status: Active
```

- `<area>` is one short word, such as `release` or `api`. Then
  `grep "· release ·"` finds every entry for that area.
- Number entries in order. Never reuse a number.

### Keep it current

- A decision that replaces an old one gets a new entry. Mark the old
  one `Superseded by D-<n>`, cut it to one line, and move it under
  `## Superseded` at the end.
- When code, a test, or a lint rule enforces a decision, delete its
  entry.
- The file opens with `## Where things stand`: at most 15 dated lines on
  where the work is, each with a pointer. Update it when a PR changes
  one of those lines.
- No decisions file yet? Create it from estack `templates/decisions-file.md`.

### Read it on demand

Do not read the whole file at the start of a session. Before you change
an area, grep its entries. Read "Where things stand" when you pick up
work you did not start, and check each line against its pointer before
you trust it.

## Answer "why"

1. Grep `<decisions file>` for the area.
2. Read the history: `git log -S '<string>'`, `git log --follow <file>`,
   and `git blame -L <lines> <file>`.
3. Read the PRs and tickets those commits name.
4. Cite what the authors wrote. Label your own inferences. Say what the
   record does not answer.
