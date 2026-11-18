# Working on estack

estack is a Claude Code plugin marketplace. Keep it DRY: every fact has
one home.

## Where each thing lives

| Thing | One home |
|---|---|
| Rules for every session | `plugins/core/rules.md` (loaded by `plugins/core/hooks/hooks.json`) |
| Codex copy of the rules | generated into `~/.codex/AGENTS.md` by `scripts/codex-setup.sh`. Never edit it. |
| How to do a task | one skill in `plugins/<plugin>/skills/<name>/SKILL.md` |
| Code-quality rules | one `principle-*` skill each in `plugins/core/skills/` |
| Credit for adapted work | `NOTICE.md` |
| Deploy process per platform | `plugins/core/skills/deploy/platforms/<platform>.md` |
| Deploy commands, hosts, paths | each repo's `AGENTS.md`, under "Deploy commands: <env>" |
| Facts about one repo | that repo's `AGENTS.md` (from `templates/AGENTS.md`) |
| Which plugins a repo uses | that repo's `.claude/settings.json` (from `scripts/init-repo.sh`) |
| Plugin description and version | `plugins/<plugin>/.claude-plugin/plugin.json` |
| README diagram | `docs/estack.svg`. Update it when skills or the workflow change. |

## Rules for changes

- Before adding text, search for it: `grep -rn "<phrase>" plugins templates`.
  If it exists, point to it instead of copying it.
- A skill names another skill as `plugin:skill` instead of repeating its steps.
- New platform: copy `platforms/_template.md`. Platform files hold
  process only, with no code blocks. Commands belong to the repo.
- Every skill goes in `core`. There is one plugin.
- This repo is public. No company names, hostnames, IPs, account IDs, or
  secrets. Those go in each repo's own `AGENTS.md`.
- Bump `version` in the plugin's `plugin.json` when you change that plugin.

## Checks

- `scripts/check.sh` validates manifests, skill names, skill references,
  platform sections, and flags rules copied out of `rules.md`.
