---
name: dev-ship
description: Use when a code change is done and proven and the task calls for a PR. Self-reviews the diff, shapes small ordered commits, pushes, opens a ready PR with the proof, and merges it only when the repo's Auto-merge table allows.
---

# Dev ship

`<base branch>`, `<proof folder>`, and `<writing skill>` come from the
repo settings in `core` rules.

1. **Self-review** `git diff origin/<base branch>...HEAD`. Remove debug code, dead
   code, secrets, and files outside the task. Check every comment against
   `core:principle-why-only-comments`. Rerun the checks.
2. **Shape the commits.** Rebase onto `origin/<base branch>` into small, ordered
   commits:
   - Each commit builds and passes the checks on its own.
   - The order tells the story: a deletion before the new code, a failing
     test before the fix.
   - A fix-up goes into the commit it belongs to:

     ```bash
     git commit --fixup <sha>
     GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash origin/<base branch>
     ```

   Rerun the checks on the last commit.
3. **Write the messages.** Titles use Conventional Commits:
   `type(scope): subject`. Types are `feat`, `fix`, `docs`, `refactor`,
   `test`, `perf`, and `chore`. The subject is imperative with no period.
   A body never repeats its title. Apply `<writing skill>`.
4. **Push**: `git push -u origin <branch>`. After rebasing a pushed
   branch, add `--force-with-lease`.
5. **Open the PR ready for review**, not as a draft. Use the repo's PR
   template if it has one. Otherwise use this body. Keep it under about
   40 lines and drop any empty section except Scope:

   ```markdown
   ## Why
   The goal and the problem, 1-3 sentences.
   ## What changed
   1-3 bullets.
   ## Scope
   What it covers and what it leaves out.
   ## Tradeoffs
   Only rejected options a reviewer would ask about.
   ## Blast radius
   Who or what it touches, and why that is safe.
   ## Verification
   1-3 bullets: the real run and its result, from <proof folder>/proof.md.
   ```

   ```bash
   gh pr create --base <base branch> --title "<type(scope): subject>" --body-file <body.md>
   ```

   Put screenshots or video after the sections.
6. **Fresh review.** Start a new agent with no chat history. Give it only
   the PR diff, the task goal, and the repo's `AGENTS.md`. Ask it for
   bugs and broken `core:principle-*` rules, each with a file and line.
   Check each finding yourself. Fix the valid ones, push, and list what
   it found in the PR. Skip this step if your tool cannot start an agent,
   and say so in the report.
7. **Bot review**, if the repo has one (Greptile, CodeRabbit, Claude).
   Fix valid findings and push. At most 3 rounds. Report the real result.
8. **Auto-merge**, only if every one of these holds. Otherwise leave the
   PR for a person.
   - A row in the "Auto-merge" table of the repo's `AGENTS.md` fits the
     change, and every file in the diff is inside that row's limits.
   - `core:change` does not apply to the change.
   - Step 6 ran, and steps 6 and 7 left no open finding.
   - Every required check passed on the last commit.
   - No person has commented on the PR or asked for changes.

   Merge with the method the repo uses (`gh pr merge <number> --merge`,
   `--squash`, or `--rebase`). Name the row you used in the PR.
9. **Report** the PR URL, checks run, whether it was auto-merged and under
   which row, and anything still open.

Keep the worktree until the PR is merged or closed.
