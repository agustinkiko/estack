# <REPO NAME>

<!-- Facts about this repo only. All rules and workflow come from estack.
     Do not copy estack rules here. Delete sections that do not apply. -->

## Deploy targets

Platform must match a file in estack `plugins/core/skills/deploy/platforms/`.

| Env | Platform | Target | URL | Health path |
|---|---|---|---|---|
| dev | compose-ssh | `<user>@<host>:<app-dir>` | `<dev-url>` | `/health` |
| prod | `<railway / vercel>` | `<target>` | `<prod-url>` | `/health` |

## Checks

- `<lint command>`
- `<typecheck command>`
- `<test command>`

## Process

- Ticket key: <ABC>
- Reviewers: <team or CODEOWNERS>
- Production approver and change tool: <...>
- Change window: <...>
- Incident process: <link or channel>
