#!/usr/bin/env bash
# Checks estack: manifests, skill names, skill references, repeated rules,
# and hard-coded repo defaults.
set -uo pipefail
cd "$(dirname "$0")/.."
fail=0
err() { echo "FAIL $*"; fail=1; }

# 1. Manifests (needs the claude CLI).
if command -v claude >/dev/null; then
  for target in . plugins/*; do
    claude plugin validate "$target" >/dev/null 2>&1 || err "claude plugin validate $target"
  done
else
  echo "skip claude plugin validate (claude CLI not found)"
fi

# 2. Each skill's frontmatter name matches its folder and has a description.
for f in plugins/*/skills/*/SKILL.md; do
  dir="$(basename "$(dirname "$f")")"
  name="$(sed -n 's/^name: //p' "$f" | head -1)"
  [ "$name" = "$dir" ] || err "$f: name '$name' != folder '$dir'"
  grep -q '^description: ' "$f" || err "$f: missing description"
done

# 3. Every plugin:skill reference points to a real skill.
refs="$(grep -rhoE '`(core|personal|work):[a-z-]+`' plugins templates README.md AGENTS.md | tr -d '`' | sort -u)"
for ref in $refs; do
  [ -f "plugins/${ref%%:*}/skills/${ref#*:}/SKILL.md" ] || err "unknown skill reference: $ref"
done

# 4. DRY: rule lines from rules.md must not be copied into other files.
while IFS= read -r line; do
  case "$line" in "- "*) ;; *) continue ;; esac
  hits="$(grep -rlF --include="*.md" -- "$line" plugins templates | grep -v 'plugins/core/rules.md')"
  [ -z "$hits" ] || err "rule repeated outside rules.md: '$line' in $hits"
done < plugins/core/rules.md

# 5. Platform files have the five sections core:deploy uses, and hold
#    process only. Commands belong in each repo's AGENTS.md, which the
#    template must give the same five sections.
for f in plugins/core/skills/deploy/platforms/*.md; do
  for s in Status "Current version" Deploy Logs Rollback; do
    grep -q "^## $s" "$f" || err "$f: missing section '## $s'"
  done
  ! grep -q '^ *```' "$f" || err "$f: code block in a platform file. Move commands to the repo's AGENTS.md."
done
for s in Status "Current version" Deploy Logs Rollback; do
  grep -q "^### $s" templates/AGENTS.md || err "templates/AGENTS.md: missing '### $s' under Deploy commands"
done

# 6. Skills use repo settings, not the defaults from rules.md.
for value in 'origin/main' 'agent/<task>' '../worktrees/' '.artifacts/' 'incidents/' 'DECISIONS.md'; do
  hits="$(grep -rlF --include="*.md" -- "$value" plugins templates | grep -v 'plugins/core/rules.md')"
  [ -z "$hits" ] || err "default '$value' hard-coded in $hits. Use the repo setting from rules.md."
done

# 7. Every script parses.
for f in scripts/*.sh; do
  bash -n "$f" || err "$f: bash syntax error"
done

[ "$fail" = 0 ] && echo "all checks passed"
exit "$fail"
