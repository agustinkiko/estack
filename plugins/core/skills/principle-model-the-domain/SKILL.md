---
name: principle-model-the-domain
description: Apply before writing logic that has states, many branches, or the same shape check in several files. Name the data shape first and let one structure hold the rules.
---

# Model the domain

Write the data shape down before you write logic. Then pick the structure
that matches the domain:

| Instead of | Use |
|---|---|
| Booleans that must stay in sync | One status field or a state machine |
| if/else chains spread across files | A lookup table, map, or tagged union |
| Loose parameters passed around | One typed object |
| State changed from many places | One reducer or command handler |

Make bad states impossible to build. A required field is required in the
type, not checked later.

You skipped this step if a new feature adds one more branch to an
existing if/else chain, or a second flag that must match the first.

Don't force it. Short, local code that won't grow can stay plain.
