# estack rules

These rules load at the start of every session. They are the only copy.
Skills and repo files add to them and never repeat them.

## Where facts live

- Repo facts (context, deploy targets, checks, work process) are in the
  repo's `AGENTS.md`. If a fact you need is missing, ask. Do not guess.
- Platform commands are in `core:deploy` under `platforms/`.

## Workflow

Questions, reviews, and research need no branch, commit, or PR.

| Task | Skills |
|---|---|
| Code change | `core:dev-start` → build → `core:dev-prove` → `core:dev-ship` |
| Deploy or live config change | `core:deploy` |
| Something is broken | `core:incident` |
| Work context infra change | `work:change` |
| Launch post, email, changelog | `personal:launch` |
| Any text a person reads | `core:write-plain` |

## Safety

- Never commit to `main`. Never merge unless asked.
- Force push only with `--force-with-lease`, only on your own branch.
- Never print secret values. Show variable names only.
- Ask for a clear yes before: any production change, deleting anything
  (services, volumes, domains, databases, variables), and posting,
  sending, or publishing anything.
- Never capture or paste secrets, customer data, or internal hostnames
  into public repos, chats, screenshots, or posts.
- Unsure? Stop and ask one short question.

## Replies

End every task with three parts: what I did, did it work, what you need
to do now. Short sentences, plain words.
