---
name: dev-start
description: Use before editing any repository for a feature, fix, or docs change. Creates an isolated git worktree and branch from the repo's base branch. Skip for read-only questions and reviews.
---

# Dev start

`<base branch>`, `<branch name>`, and `<worktree folder>` come from the
repo settings in `core` rules.

## Steps

1. If this task already has a worktree, use it and stop:
   `git worktree list`, `git branch --show-current`.
2. `git fetch origin`.
3. Check overlap: `gh pr list`, then `gh pr diff <n> --name-only`.
   If another open PR changes the same behavior, stop and ask.
4. Name the task: lowercase words and hyphens, for example `fix-login`.
   Put it in place of `<task>` in `<branch name>` and `<worktree folder>`.
   - `<branch name>` lists choices, such as a fix prefix and a feature
     prefix? Take the one that matches the task.
   - It has `<username>`? Use `gh api user --jq .login`.
   - The branch already exists? Add a 4-character suffix to the task name.
5. If `<worktree folder>` is inside the repo, it must be ignored:
   `git check-ignore -q <worktree folder>`. If that fails, stop and ask.
6. Create and enter it:

   ```bash
   git worktree add <worktree folder> -b <branch name> origin/<base branch>
   cd <worktree folder>
   git branch --show-current
   ```

   The last line must print `<branch name>`.
7. Install dependencies in the worktree only if the checks need them.

## Remember

- Worktrees share ports and databases. Confirm a port is yours:
  `lsof -i :<port>`.
- Lockfile conflict: regenerate it, never hand-merge.
- After merge:

  ```bash
  git worktree remove <worktree folder>
  git branch -D <branch name>
  ```
