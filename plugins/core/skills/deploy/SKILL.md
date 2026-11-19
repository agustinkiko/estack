---
name: deploy
description: Use when deploying a service or changing its live config (env vars, domains, scaling), to a dev server or production, on any platform - home lab, Railway, Vercel, and more. One procedure. The process comes from platforms/<platform>.md, and the targets and commands come from the repo's AGENTS.md.
---

# Deploy

estack holds the process. The repo holds the facts: where each
environment runs and the exact commands for it.

## 1. Find the target

Read the "Deploy targets" table in the repo's `AGENTS.md`. Rows are in
release order, and the last row is production. Take the row for the
environment asked for. It gives the platform, target, branch, URL, and
health path.

## 2. Load the process and the commands

1. Read `platforms/<platform>.md` in this skill's folder. It says what
   each step must do and what to check, for any repo on that platform.
2. Read the "Deploy commands: <env>" section. It is in the repo's
   `AGENTS.md`, or in a file `AGENTS.md` links to. It has the exact commands for the same five steps: Status, Current
   version, Deploy, Logs, Rollback.
3. Run only the repo's commands. Check each result against the platform
   file.

No commands for that environment? Write them with the user from the
platform file, and add them where the repo keeps its deploy commands
before you deploy.
No platform file? Copy `platforms/_template.md`, fill it in with the
user, and add it to estack.

## 3. Preflight

1. Run **Status**. Run **Current version** and write down the result.
   That is the rollback.
2. Production only:
   - The change is merged to the row's branch and its checks passed.
   - It ran on the row above first.
   - Any database migration is safe to run before the new code is live.
   - Infrastructure change: finish `core:change` first.

## 4. Deploy and verify

1. Run **Deploy**. Watch **Logs** until it finishes.
2. Health check:

   ```bash
   curl -s -o /dev/null -w "%{http_code}\n" <url><health-path>
   ```

   Expect `200`.
3. Watch **Logs** for 5 minutes. Look for new errors.

## 5. If it fails

Run **Rollback** with the version from preflight. Then debug on the row
above.
Do not stack fixes on a broken production deploy.

## Report

Environment, platform, new version, health result, rollback version.
