---
name: typescript-best-practices
description: Use when reading, writing, or reviewing any .ts or .tsx file. TypeScript rules for discriminated unions, branded types, schemas, narrowing, exhaustive switches, and no `as` casts.
paths: ["**/*.ts", "**/*.tsx"]
---

# TypeScript best practices

Apply `core:principle-type-system-discipline` first. This skill is the
TypeScript syntax for it. Examples for each rule are in
`references/patterns.md`.

| Rule | Summary |
|---|---|
| Discriminated unions | Model variants with a `kind` literal field, so impossible states cannot exist. No bag of optional fields. |
| Branded types | Brand primitives with `& { readonly __brand: "X" }` so they cannot be mixed up. A brand comes from a type guard that checks (`input is AgentId`), never from `as`. |
| Build legal shapes | `[T, ...T[]]` for non-empty, `[T, T][]` for pairs, `start` plus `durationMs` for a range. The bad value cannot be built. |
| Simplest total type | Keep `T[]` while every operation on it is total. Use `NonEmpty<T>` only where `T[]` forces `!`, a cast, or a "should never happen" throw. |
| `unknown`, not `any` | Outside data is `unknown` until parsed. |
| Schemas before guards | Before a hand-written type guard, use the repo's schema library and infer the type (`z.infer`). Never add a schema library for one guard. |
| No `as` casts | Every `as` is a crash waiting. Cast only after validation. |
| Narrowing order | Discriminant `switch`, then `in`, then `typeof` or `instanceof`, then a type guard, then `as`. |
| Honest type guards | A guard checks every part of its claim. A lying guard is worse than `as`. Name it `isX` or `hasX`. |
| Exhaustiveness | In the `default` arm: `const _exhaustive: never = x;`. A new variant then fails the build. |
| `satisfies`, not `as` | `satisfies` checks a value and keeps its literal types. |
| Parse at the edge | `Record<string, unknown>` stops at the parse into a named domain type. |
| Derive types | Use `Pick`, `Omit`, `Parameters`, `ReturnType`, `Awaited`, and `typeof` before you declare a new interface. |
| Object arguments | Pass one object, not positional values, so callers cannot swap arguments. Skip on hot paths: render loops, tokenizers, parsers. |
| Logging | Structured logger with an ID to debug from. No `console.log` in shipped code. |
