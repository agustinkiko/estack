---
name: principle-minimize-reader-load
description: Apply when shaping or reviewing code that is hard to follow. Cut the layers and hidden state a reader must keep in their head.
---

# Minimize reader load

A reader pays for two things: layers to trace and state to hold.

- Inline wrappers with one caller and adapters with one implementation.
- Remove pass-through layers that repeat the same methods and arguments.
- Prefer returning a value over changing one. Then locals over fields,
  fields over module state. Avoid globals.
- Derive a value instead of keeping two copies in sync.
- State a rule once, where data enters, not in every consumer.

The test: a new reader can answer "where does X come from?" and "what can
change X?" in 30 seconds.
