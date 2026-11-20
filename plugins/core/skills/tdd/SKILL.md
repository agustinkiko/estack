---
name: tdd
description: Use when fixing a bug that has a cheap local test path, or when the user asks for TDD, a failing test, or a regression test. Writes one focused test that fails before the fix and passes after. Skip when the only test path is slow, flaky, or needs production state.
---

# TDD bug fix

Make the bug fail in a test before you change the code.

## Steps

1. **Understand the bug.** Write down the intended behavior, the current
   behavior, and the smallest input that shows the gap.
2. **Pick the narrowest test.** Use the closest unit, component, or
   integration test the repo already has for that code. No test path in
   sight? Do not build a harness for it. Go to "When a test is not
   practical".
3. **Write the failing test.** The smallest test that would have caught
   the bug. It asserts the intended behavior
   (`core:principle-test-behavior`).
4. **Run it before the fix.** It must fail, and for the reason you
   expect. It passes, or fails for another reason? Fix the test first.
5. **Commit the test**, as `core:principle-sequence-verifiable-units`
   says. Then make the smallest code change that makes it pass.
6. **Rerun** the test and the tests near it.

Save the failing run and the passing run as the before and after proof
in `core:dev-prove`.

## When a test is not practical

Use the closest check you can rerun: a script, a command and its output,
browser automation, or a log assertion.

No new test beats a bad test. A bad test mostly tests mocks, copies the
current implementation, depends on timing or global state, needs costly
setup for a small fix, or would be deleted right after.

## Guardrails

- Never change a test to match a wrong implementation.
- Never weaken an assertion unless the intended behavior changed. Say
  why in the commit.
- Keep the test on this bug. No unrelated fixture churn.
- Flaky bug? Make the test deterministic: fix the clock, the seed, or
  the order.
- The bug is one of a class? Land this test first. Add sibling cases
  after.

## Report

- The failing test before the fix, and the failure it printed.
- The passing run after the fix, and the other checks you ran.
- No failing test? Say why, and name the check you used instead.
