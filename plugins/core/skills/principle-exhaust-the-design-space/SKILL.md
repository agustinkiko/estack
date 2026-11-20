---
name: principle-exhaust-the-design-space
description: Apply when a UI interaction, product flow, or architecture choice has no precedent in the codebase, or when the right answer depends on how it feels to use. Build two or three rough prototypes and compare them side by side before you commit to one.
---

# Exhaust the design space

- Check for precedent first: the codebase and the decisions file
  (`core:decisions`). A pattern the repo already uses wins unless it
  fails the need.
- No precedent? Build 2 or 3 competing prototypes. Keep each one cheap,
  but real enough to run or click.
- Name the criteria before you build: the user's task, the code each
  option needs, and how each one fails.
- Compare them side by side. Pick one. Delete the others, and ship only
  the winner.
- Log the choice and the rejected options with `core:decisions`, so a
  future agent does not rebuild a loser.
- Product design counts too, where the answer depends on feel, not
  logic. Show the user the options running, not described.
