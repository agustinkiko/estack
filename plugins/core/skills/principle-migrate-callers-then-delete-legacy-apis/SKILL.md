---
name: principle-migrate-callers-then-delete-legacy-apis
description: Apply when a new internal function, module, or API replaces an old one that still has callers. Move every caller and delete the old API in the same change. No compatibility layers for internal code.
---

# Migrate callers, then delete legacy APIs

- When a new internal API replaces an old one, move every caller in the
  same change or PR stack. Then delete the old API.
- No wrappers, aliases, shims, or "deprecated" copies for internal
  callers. Each one doubles the paths a reader and a test must cover.
- Find every caller first: the symbol, its name as a string, config keys,
  and dynamic lookups. `core:blast-radius` covers what grep misses.
- Update tests to assert the new contract. Delete tests that only guard
  the old internals.
- Order: new API, then callers moved, then old API deleted
  (`core:principle-sequence-verifiable-units`).

## When it applies

- No outside user depends on the old API.
- The project can take a coordinated breaking change.

Outside users depend on it (a published package, a public API, another
team's service)? Keep the old API, mark it deprecated with a removal
date, and log the plan with `core:decisions`.
