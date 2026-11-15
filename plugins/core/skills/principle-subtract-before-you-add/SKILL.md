---
name: principle-subtract-before-you-add
description: Apply before building a feature, refactor, or rewrite on top of existing code. Remove dead or obsolete code first, then build on the simpler base.
---

# Subtract before you add

- Delete first: dead code, unused options, old adapters, stale flags,
  empty stub files.
- Commit the deletion on its own, before the new work.
- Design for how the code is used today, not for guessed future cases.
- Leave the area simpler than you found it, behind the same or a smaller
  interface.
