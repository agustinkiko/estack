---
name: technical-writing
description: Use when writing or reviewing a doc page - README, tutorial, how-to, runbook, reference, RFC, design doc, or explanation. Picks one doc type, then applies sentence rules for tired engineers and non-native readers. Run the repo's writing skill after it.
---

# Technical writing

Write so a tired engineer understands on the first read. Docs go in
`<docs home>`. This skill shapes the page. `<writing skill>` cuts slop
from the sentences. Run it last.

- Write the real symbol, file, flag, or command, not a description of it.
- Use the words a developer says out loud. Explain a named pattern the
  first time you use it.
- When a rule makes a sentence worse, fix the sentence another way.

## 1. Pick one doc type (Diátaxis)

One page, one type. Do not mix types. Split the page and link instead.

| Type | Reader wants | Rules |
|---|---|---|
| Tutorial | to learn by doing | Say what they will build. Each step shows a result, and you say what they should see. Explanation gets one clause and a link. |
| How-to | to reach a goal | Steps only. Assume skill. Allow forks. Name the page after the task. |
| Reference | to look up a fact | Describe only. Dry, complete, and sure. Mirror the structure of the thing described. |
| Explanation | to understand why | One topic. Give context: decisions, history, limits, other options. Opinion goes here and nowhere else. |

## 2. Talk to the reader (Google developer style)

- Write to "you", in the present tense.
- Write steps as commands. Put the condition first, and the common case
  first.
- No "please", "simply", "easy", or "quickly" in a step.
- Do not announce what comes next. Do not start two sentences in a row
  with the same words.
- Link text says where the link goes. Never "click here".
- Headings state the point, in sentence case. One h1. No skipped levels.
- Numbered lists for steps, bullets for the rest. Introduce a list with a
  full sentence. Keep items parallel.
- Code, paths, and commands in code font. UI labels in bold. Use the
  serial comma.

## 3. One step at a time (Simplified Technical English)

- One instruction per sentence.
- Split a step over about 20 words, and any other sentence over about 25.
- Put a warning before the step it guards.
- Keep "the" and "a".
- One word per meaning, and one word per action.
- Avoid "-ing" words where you can.

## 4. One reading only (Global English)

- Put "only" and "not" next to the word they change.
- Break up long chains of nouns.
- Each "it", "they", and "this" points at one clear thing. Never use
  "this" or "which" for a whole clause.
- Keep the small words that show structure, such as "that".
- No semicolons, slashes, or "(s)".
- Call each thing by one name everywhere.
- No idioms, metaphors, or Latin abbreviations such as "e.g." and "etc.".

## 5. Keep it true

Every count, path, and file tree in the doc is true at the commit that
lands it. Show the command that regenerates it.
