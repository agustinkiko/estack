---
name: dev-prove
description: Use after changing runtime behavior and before opening a PR. Captures proof that the change works, with the failure before the fix and the success after. Skip for docs-only edits.
---

# Dev prove

Proof is something a reviewer can see without running the code. Check
the real thing, not a proxy. A passing build, a file timestamp, or an
agent's report is not proof.

| Change | Proof |
|---|---|
| Bug fix | Failing test or error before, passing after |
| UI | Screenshots before and after, same viewport |
| API or CLI | Command and output, before and after |
| Performance | Numbers before and after, same machine |

## Steps

1. Before the fix, reproduce the problem. Save to `.artifacts/<task>/01-before.*`.
   If the bug has a cheap test path, write the failing test first and
   commit it before the fix (`core:principle-test-behavior`).
2. Make the change.
3. Run the same thing. Save to `.artifacts/<task>/02-after.*`.
4. Run the checks from the repo's `AGENTS.md`. Save the output.
5. Write `.artifacts/<task>/proof.md`: commit (`git rev-parse --short HEAD`),
   then one line per test with `passed`, `failed`, or `untested` and why.

Look at each result before you mark it `passed`. Prefer a script that
reruns the check, and keep it in `.artifacts/<task>/` next to its output
so a reviewer can rerun it. `.artifacts/` stays gitignored. Proof goes in
the PR, not in commits.

## Screenshots without a desktop

```js
import { chromium } from "playwright";
const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1280, height: 800 } });
await page.goto("http://localhost:3000/page-under-test");
await page.screenshot({ path: ".artifacts/<task>/02-after.png" });
await browser.close();
```
