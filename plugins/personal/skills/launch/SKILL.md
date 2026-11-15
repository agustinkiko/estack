---
name: launch
description: Use when turning shipped work on my own apps into marketing - a changelog entry, X or LinkedIn post, launch email, or short blog post. Pulls facts from merged PRs and drafts in plain language.
---

# Launch

Facts first, then words.

## 1. Gather facts

- `gh pr list --state merged --search "merged:>=YYYY-MM-DD"`
- For each PR: what can the user do now that they could not before?
- Proof: a screenshot from `.artifacts/`, a number, or a user quote.
- Skip internal work (refactors, CI) unless it changes speed or cost for users.

## 2. Pick the format

The audience and voice are in the repo's `AGENTS.md` under "Marketing".

| Format | Length | Shape |
|---|---|---|
| Changelog | 1-3 lines per item | What changed. Why it matters. Link. |
| X | under 280 chars | One feature, one benefit, one image. |
| LinkedIn | 80-150 words | Problem, what we built, result, link. |
| Email | under 200 words | Subject is the benefit. One call to action. |

## 3. Draft

- Open with what the reader gets, with a number or a concrete example.
- One call to action.
- Use a real screenshot. Generated images only if asked.
- Apply `core:write-plain`.

## 4. Hand off

Save to `marketing/drafts/YYYY-MM-DD-<topic>.md` and show it.
