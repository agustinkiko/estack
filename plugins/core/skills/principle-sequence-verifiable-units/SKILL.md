---
name: principle-sequence-verifiable-units
description: Apply to multi-step work (sweeps, migrations, runs of similar edits) and when stacking commits or PRs. Split the work into small units that each end in a state you can check, check each one before the next, and order the commits so they prove the work.
---

# Sequence verifiable units

- Split multi-step work into small units. Each unit ends in a state you
  can check.
- Work each unit as a bracket: start from a known-good state, make one
  change, run the check, then move on. Never start the next unit while
  the check is red.
- Run the per-unit check even when a tool or script made the edits.
- Deliver in the order that proves the work: the failing test before the
  fix, the deletion before the reshape, the baseline before the change.
- Each commit builds and passes the checks on its own. A failing test
  that lands before its fix is marked expected-to-fail (`test.fails`,
  `it.failing`, `pytest.mark.xfail(strict=True)`). The fix commit removes
  the mark.
