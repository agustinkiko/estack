---
name: principle-smallest-diff
description: Apply when sizing a change, or when tempted to add an abstraction, layer, option, or helper. Make the smallest change that solves the problem.
---

# Smallest diff

- Solve the problem you were given. Leave the code next to it alone.
- Fewer lines beat clever structure. Add a layer, option, or helper only
  for a second real caller or a named benefit, such as testing or a
  provider boundary.
- Make each decision once. If the same choice appears in two places, keep
  it in one place and pass the result.
- No "just in case" code. Skip guards, retries, config, and fallbacks for
  cases nobody has seen.
- Before you finish, read the diff and delete what the task does not need.
