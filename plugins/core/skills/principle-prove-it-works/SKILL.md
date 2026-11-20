---
name: principle-prove-it-works
description: Apply after any task and before you call it done, including code, config, deploys, and data fixes. Check the real thing (run the feature, read the actual value, open the diff), not a proxy, a self-report, or "it compiles".
---

# Prove it works

- Check the real thing: run the feature, read the actual value, open the
  diff, load the page.
- A proxy is not proof. "It compiles", a passing build, a file timestamp,
  cached output, and an agent's report of its own work all count as
  proxies.
- When a check fails, suspect the way you checked before the system. A
  wrong path, a stale build, or the wrong environment fails too.
- Script the check when you can. A script that reruns the comparison
  beats one look. Keep its output where the user can see it.
