---
name: principle-type-system-discipline
description: Apply when designing types, writing or reviewing a function signature, or writing code in any statically typed language, including typed Python. Make the type checker reject mixed-up values, impossible states, and unhandled cases.
---

# Type system discipline

Let the type checker catch the bug before a test has to.

- **Give each meaning its own type.** Two values that share a primitive
  but mean different things (a user ID and an order ID, cents and
  dollars) get separate types. Check the value once, where it is created.
- **Make bad states impossible to build.** Use the structures in
  `core:principle-model-the-domain`.
- **Handle every case.** Switch on the variant and make the checker fail
  when a new variant has no branch. A default arm must not hide a
  missing case.
- **Outside data has no type until it is parsed.** Follow
  `core:principle-boundary-discipline`.
- **Derive types from the schema that owns the shape**: an OpenAPI spec,
  a proto, a database schema, or a runtime validator. Never hand-write a
  second copy that can drift.
- **No casts to quiet the checker.** A cast is a claim nobody checked.
  Cast only right after a check that proves it.
- **Use the simplest type that keeps every operation total.** Make a type
  stricter only where the loose one forces a cast, a non-null assertion,
  or a "should never happen" error.

Syntax for each language: `core:typescript-best-practices`,
`core:python-best-practices`.
