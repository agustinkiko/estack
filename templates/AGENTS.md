# <REPO NAME>

<!-- Facts about this repo only. All rules and workflow come from estack.
     Do not copy estack rules here. Delete sections that do not apply.
     Agents load this file every session, so keep it short. Move long
     sections, such as deploy commands, into files it links, and say when
     to read each one. Past decisions go in the decisions file from
     estack `core:decisions`. -->

## Repo settings

Settings and defaults are in estack `plugins/core/rules.md`. Add a row
only to change a default.

| Setting | Value |
|---|---|
| `<base branch>` | `<main>` |

## Deploy targets

Platform must match a file in estack `plugins/core/skills/deploy/platforms/`.
Rows go in release order. The last row is production.

| Env | Platform | Target | Branch | URL | Health path |
|---|---|---|---|---|---|
| dev | compose-ssh | `<user>@<host>:<app-dir>` | `<branch>` | `<dev-url>` | `/health` |
| prod | `<railway / vercel>` | `<target>` | `main` | `<prod-url>` | `/health` |

## Deploy commands: <env>

One section per row above. The exact commands for this repo. estack's
`platforms/<platform>.md` says what each step must do and check.

### Status

```bash
<command>
```

### Current version

```bash
<command>
```

### Deploy

```bash
<commands, in order>
```

### Logs

```bash
<command>
```

### Rollback

```bash
<command that returns to <version>>
```

## Checks

- `<lint command>`
- `<typecheck command>`
- `<test command>`

## Auto-merge

Change types the agent may merge without asking. `core:dev-ship` lists
the other conditions. No section means you review every PR. A row is
your yes in advance, including to any deploy that the merge starts.

| Change type | Limits |
|---|---|
| `<docs only>` | `<only *.md files>` |
| `<dependency patch bump>` | `<manifest and lockfile only, patch versions>` |

## Process

- Ticket key: <ABC>
- Reviewers: <team or CODEOWNERS>
- Production approver and change tool: <...>
- Change window: <...>
- Incident process: <link or channel>
