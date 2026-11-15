---
name: principle-test-behavior
description: Apply when writing, changing, or keeping a test. Test what users of the code can see, so the test fails when that breaks and survives changes to the internals.
---

# Test behavior, not implementation

Behavior is what callers and users can see: return values, errors, saved
data, requests sent. Implementation is what they cannot see: private
helpers, call order, internal data.

Judge each test with two imagined edits:

1. **Break the behavior**, for example return a wrong value or skip a
   save. If the test still passes, it proves nothing. Fix or delete it.
2. **Restructure the internals** and keep every result the same. If the
   test now fails, it is pinned to the implementation. Rewrite it.

Drive the code through its public interface with a concrete input. Take
the expected value from the requirement, never from a run of the code.
