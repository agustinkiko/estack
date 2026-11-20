---
name: blast-radius
description: Use before shipping a change to shared code, a contract (API, schema, wire format, env var, config key, feature flag), or a deletion. Also use when asked "what could this break" or to review a small diff you do not trust. Finds breakage outside the diff and proves, by running real code, the one fact the change is safe because of.
---

# Blast radius

Find what a change breaks outside the diff, before it ships.

Listing callers is not the job. Grep does that in a second. The job is
the breakage grep does not show.

## How sure are you

A write-up that sounds right reads the same whether or not it is true.
So for each fact the change's safety depends on, push it as far down
this list as is cheap, and say where it stopped:

1. You said so. Worth nothing alone.
2. You pointed at the line: a real `file:line`, or the library's own
   source.
3. You walked the failure step by step and showed it cannot happen.
4. You ran it: a script or test calls the real code and fails loudly if
   you are wrong.
5. You reproduced it in the running app.

Level 4 is usually one small script that imports the library the app
ships and calls the exact function you worry about.

## Steps

1. **Read the change.** The diff, the symbols it adds, changes, and
   deletes, and what now behaves differently, including what the diff
   does not spell out.
2. **Find the one fact it is safe because of.** Most risky-looking
   changes are safe because of one fact, such as "this call only drops
   cache entries that are already dead". If it holds, most risks clear at
   once. Spend your time here, not on a long list of maybes.
3. **Look where grep stops.** Read the source of the library you call,
   at the pinned version, with any local patch. Work out when things run:
   async order, teardown, retries. Follow what a symbol search misses:
   JSON an API returns, a database column, a wire format, another
   language reading the same bytes, a feature flag, a config key, a
   caller three hops away.
4. **Rate each risk honestly**, with a real chance and a real cost. Keep
   the confirmed risks. List the ones you checked and cleared apart. Cite
   real `file:line`. A search that finds nothing is an answer. Never
   invent a caller or an API.
5. **Prove the one fact.** Write a script or test that runs the real
   code, and run it. Save both in `<proof folder>`.
6. **Big or wide change?** Ask a fresh agent with no chat history the
   same question. Merge both answers. A second look catches different
   bugs.

## Report

It goes in the PR's "Blast radius" section (`core:dev-ship`):

- **What it does**, including the part that is not obvious.
- **Safe because**: the one fact, the level it reached, and the proof.
  Could not prove it? Write `unproven`.
- **Risks**: how each one breaks, `file:line`, how likely, how bad, and
  how to check.
- **Cleared**: what you checked and why it is fine.
- **Before merge**: the cheapest test or repro that catches the real
  bug, with the script.
