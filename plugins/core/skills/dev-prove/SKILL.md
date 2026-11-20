---
name: dev-prove
description: Use after changing runtime behavior and before opening a PR. Captures proof that the change works, with the failure before the fix and the success after. Skip for docs-only edits.
---

# Dev prove

Proof is something a reviewer can see without running the code. What
counts as proof is in `core:principle-prove-it-works`.

| Change | Proof |
|---|---|
| Bug fix | Failing test or error before, passing after (`core:tdd`) |
| UI | Screenshots before and after, same viewport |
| API or CLI | Command and output, before and after |
| Performance | Numbers before and after, same machine (`core:principle-explain-the-number`) |

`<proof folder>` and `<verify skill>` come from the repo settings in
`core` rules. Git must ignore `<proof folder>`. If
`git check-ignore -q <proof folder>` fails, add the folder to
`.git/info/exclude`. That file stays on this machine.

## Steps

1. Before the fix, reproduce the problem. Save to `<proof folder>/01-before.*`.
   If the repo names a `<verify skill>`, use it to start and drive the
   app here and in step 3.
   If the bug has a cheap test path, follow `core:tdd`.
2. Make the change.
3. Run the same thing. Save to `<proof folder>/02-after.*`.
4. Run the checks from the repo's `AGENTS.md`. Save the output.
5. Write `<proof folder>/proof.md`: commit (`git rev-parse --short HEAD`),
   then one line per test with `passed`, `failed`, or `untested` and why.

Look at each result before you mark it `passed`. Keep each check script
in `<proof folder>` next to its output, so a reviewer can rerun it.
Proof goes in the PR, not in commits.

## Screenshots without a desktop

```js
import { chromium } from "playwright";
const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1280, height: 800 } });
await page.goto("http://localhost:3000/page-under-test");
await page.screenshot({ path: "<proof folder>/02-after.png" });
await browser.close();
```
