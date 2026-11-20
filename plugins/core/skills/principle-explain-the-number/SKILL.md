---
name: principle-explain-the-number
description: Apply before you measure, and before you trust, report, or act on a measured number - a speedup, a regression, throughput, latency, memory, cost, or an eval score. Find what limits it, and rule out that it measured something other than the work you think.
---

# Explain the number

- **Write the decision before you run.** Name the result that would
  change it and the noise floor. Stop when the spread between runs is
  bigger than the effect.
- **Ask "why not twice as fast?"** Name the resource or code path that
  limits the result, from a profile or counters taken during the run. A
  guess from reading the code is not a limit.
- **List what else the number could measure**, and rule out each one
  with evidence: errors, skipped or cached work, code that never ran, an
  untuned baseline, noise, a part too small to matter.
- **Keep the run count, the spread, and the limit with the number** every
  time you report it.

For a benchmark: same machine, same inputs, warm-up runs first, several
runs, and report the median with the spread.

For an eval: check that every run did the task, that the gap holds
across trials and models, and that the scenario matters.
