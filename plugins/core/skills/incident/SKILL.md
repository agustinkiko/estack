---
name: incident
description: Use when something in production is broken, slow, or erroring. Sizes it, finds what changed, stops the harm, then writes a short incident note.
---

# Incident

Order: stop the harm, find the cause, write it down.

## 1. Size it

What is broken, who is affected, since when.
**S1** down or data at risk. **S2** a main feature broken. **S3** minor.
Also follow the incident process in the repo's `AGENTS.md`.

## 2. What changed?

Newest first:
- Recent deploys: **Current version** and **Logs** in `core:deploy`.
- Recent merges: `git log origin/<base branch> --since="24 hours ago" --oneline`.
- Env var or config changes.
- Status pages of services you depend on.

## 3. Stop the harm

If a deploy lines up with the start time, roll it back with `core:deploy`
step 5. Do not debug in production while users are hurting.

## 4. Find the cause

Follow `core:principle-fix-root-causes`. Read logs around the start time
and find the first error, not the loudest. Fix it through the code change
workflow.

## 5. Write the note

Put it in `<docs home>` from the repo settings in `core` rules, named
`YYYY-MM-DD-<short-name>`. If `<docs home>` is outside the repo, create
the page there and put its link in the report.

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
