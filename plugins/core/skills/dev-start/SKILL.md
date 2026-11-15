---
name: dev-start
description: Use before editing any repository for a feature, fix, or docs change. Creates an isolated git worktree and branch from origin/main. Skip for read-only questions and reviews.
---

# Dev start

## Steps

1. If this task already has a worktree, use it and stop:
   `git worktree list`, `git branch --show-current`.
2. `git fetch origin`.
3. Check overlap: `gh pr list`, then `gh pr diff <n> --name-only`.
   If another open PR changes the same behavior, stop and ask.
4. Name the task: lowercase, hyphens, 4-char suffix. Example: `fix-login-a1b2`.
5. Create and enter it:

   ```bash
   git worktree add ../worktrees/<task> -b agent/<task> origin/main
   cd ../worktrees/<task>
   git branch --show-current
   ```

   The last line must print `agent/<task>`.
6. Install dependencies in the worktree only if the checks need them.

## Remember

- Worktrees share ports and databases. Confirm a port is yours:
  `lsof -i :<port>`.
- Lockfile conflict: regenerate it, never hand-merge.
- After merge:

  ```bash
  git worktree remove ../worktrees/<task>
  git branch -D agent/<task>
  ```
