---
name: principle-why-only-comments
description: Apply whenever you write or keep a code comment, including in tests and scripts. Keep a comment only for a non-obvious reason the code cannot show.
---

# Why-only comments

- Delete comments that restate the code, narrate steps
  (`// Step 1: load users`), or describe a change (`// fixed bug`).
- Keep a comment for a reason the reader cannot see: an outside rule
  (an API limit, a platform bug, a law), a surprising choice, a known trap.
- A comment that says "do not remove" or "do not change" becomes a test,
  type, or lint check when it can. Then delete the comment.
- A workaround that needs a long comment to justify it is a sign the code
  is wrong. Fix the code.
- In tests and scripts, the assertion or log message names the step:
  `assert(saved, "persists after restart")`.
