---
name: principle-fix-root-causes
description: Apply when debugging or fixing a bug. Reproduce it, trace it to the first wrong decision in the code, and fix it there, not where the symptom shows.
---

# Fix root causes

- Reproduce first. No repro, no fix.
- Ask "why" until the answer is a wrong decision in the code, not the
  result of an earlier one.
- When stuck, add logging and read the real state. Don't guess.
- Is the state that broke things allowed to exist? If yes, the code that
  broke on it is the bug. If no, find what created that state. A guard
  where it broke only hides the bug.
- Extra guards, retries, swallowed errors, and clamped values hide bugs.
  Don't ship them as fixes.
- Fails only after a restart? Suspect saved state first: config, cache,
  lock files.
- Fix every place with the same fault, not only this one.
- Ship only what the evidence supports. Revert changes made for a theory
  the evidence ruled out.
