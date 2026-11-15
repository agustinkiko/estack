---
name: incident
description: Use when something in production is broken, slow, or erroring. Sizes it, finds what changed, stops the harm, then writes a short incident note.
---

# Incident

Order: stop the harm, find the cause, write it down.

## 1. Size it

What is broken, who is affected, since when.
**S1** down or data at risk. **S2** a main feature broken. **S3** minor.
Work context: also follow the incident process in the repo's `AGENTS.md`.

## 2. What changed?

Newest first:
- Recent deploys: **Current version** and **Logs** in `core:deploy`.
- Recent merges: `git log origin/main --since="24 hours ago" --oneline`.
- Env var or config changes.
- Status pages of services you depend on.

## 3. Stop the harm

If a deploy lines up with the start time, roll it back with `core:deploy`
step 5. Do not debug in production while users are hurting.

## 4. Find the cause

Read logs around the start time. Find the first error, not the loudest.
Fix it through the code change workflow.

## 5. Write the note

`incidents/YYYY-MM-DD-<short-name>.md`:

```markdown
# <What broke>
- Severity:
- Start / end (with time zone):
- Impact:
- Cause:
- Fix: (link to PR)
- Follow-up:
```

Facts and times only. No blame.
