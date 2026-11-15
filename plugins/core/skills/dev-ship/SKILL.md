---
name: dev-ship
description: Use when a code change is done and proven and the task calls for a PR. Self-reviews the diff, rebases, pushes, and opens a draft PR with the proof.
---

# Dev ship

1. **Self-review** `git diff origin/main...HEAD`. Remove debug code,
   commented-out code, secrets, and files outside the task. Add error
   handling to new network and database calls. Rerun the checks.
2. **Rebase**: `git fetch origin && git rebase origin/main`. Rerun the checks.
3. **Commit** with one message: what changed and why. Apply `core:write-plain`.
4. **Push**: `git push -u origin <branch>`.
5. **Draft PR.** Use the repo's PR template if there is one. Otherwise:

   ```markdown
   ## What changed
   ## Why
   ## How I tested it
   (from .artifacts/<task>/proof.md)
   ## Risks
   ```

   ```bash
   gh pr create --draft --title "<title>" --body-file <body.md>
   ```

6. **Bot review**, if the repo has one (Greptile, CodeRabbit, Claude).
   Fix valid findings and push. At most 3 rounds. Report the real result.
7. **Report** the PR URL, checks run, and anything still open.

Keep the worktree until the PR is merged or closed.
