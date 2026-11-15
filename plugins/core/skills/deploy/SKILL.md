---
name: deploy
description: Use when deploying a service or changing its live config (env vars, domains, scaling), to a dev server or production, on any platform - home lab, Railway, Vercel, and more. One procedure; the target comes from the repo's AGENTS.md and the commands from platforms/<platform>.md.
---

# Deploy

## 1. Find the target

Read the "Deploy targets" table in the repo's `AGENTS.md`. Take the row
for the environment asked for. It gives the platform, target, URL, and
health path.

## 2. Load the platform

Read `platforms/<platform>.md` in this skill's folder. It has five
sections: Status, Current version, Deploy, Logs, Rollback.
No file for that platform? Copy `platforms/_template.md`, fill it in
with the user, and add it to estack.

## 3. Preflight

1. Run **Status**. Run **Current version** and write down the result.
   That is the rollback.
2. Production only:
   - The change is merged to `main` and its checks passed.
   - It ran on dev first.
   - Any database migration is safe to run before the new code is live.
   - Work context: finish `work:change` first.

## 4. Deploy and verify

1. Run **Deploy**. Watch **Logs** until it finishes.
2. Health check:

   ```bash
   curl -s -o /dev/null -w "%{http_code}\n" <url><health-path>
   ```

   Expect `200`.
3. Watch **Logs** for 5 minutes. Look for new errors.

## 5. If it fails

Run **Rollback** with the version from preflight. Then debug in dev.
Do not stack fixes on a broken production deploy.

## Report

Environment, platform, new version, health result, rollback version.
