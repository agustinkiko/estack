---
name: principle-boundary-discipline
description: Apply when wiring input handling, validation, error handling, or a framework or API adapter. Check data where it enters the system, then trust it inside.
---

# Boundary discipline

- Parse outside data where it enters: requests, env vars, files, API
  responses, user input. Turn it into a typed shape there.
- Inside, trust the types. No repeated null checks or second validation
  deep in the code.
- Keep business logic free of framework and network calls, so plain
  inputs can test it.
- Handle an error in the layer that can act on it. Never catch and ignore.
