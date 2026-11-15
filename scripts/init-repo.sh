#!/usr/bin/env bash
# Connect a repo to estack.
# Usage: scripts/init-repo.sh <personal|work> <path-to-repo>
# Writes .claude/settings.json, plus AGENTS.md and CLAUDE.md if missing.
set -euo pipefail

context="${1:-}"
repo="${2:-}"
case "$context" in
  personal|work) ;;
  *) echo "usage: $0 <personal|work> <path-to-repo>" >&2; exit 1 ;;
esac
[ -d "$repo" ] || { echo "not a directory: $repo" >&2; exit 1; }

stack="$(cd "$(dirname "$0")/.." && pwd)"
settings="$repo/.claude/settings.json"
mkdir -p "$repo/.claude"

new_settings="$(cat <<EOF
{
  "extraKnownMarketplaces": {
    "estack": { "source": { "source": "github", "repo": "agustinkiko/estack" } }
  },
  "enabledPlugins": {
    "core@estack": true,
    "$context@estack": true
  }
}
EOF
)"

if [ -f "$settings" ]; then
  command -v jq >/dev/null || { echo "$settings exists and jq is not installed. Merge by hand." >&2; exit 1; }
  jq -s '.[0] * .[1]' "$settings" <(echo "$new_settings") > "$settings.tmp"
  mv "$settings.tmp" "$settings"
  echo "merged   $settings"
else
  echo "$new_settings" > "$settings"
  echo "created  $settings"
fi

name="$(basename "$(cd "$repo" && pwd)")"
if [ ! -f "$repo/AGENTS.md" ]; then
  sed -e "s/<REPO NAME>/$name/" -e "s/<personal | work>/$context/" \
    "$stack/templates/AGENTS.md" > "$repo/AGENTS.md"
  echo "created  $repo/AGENTS.md  (fill in the <...> fields)"
else
  echo "kept     $repo/AGENTS.md"
fi

if [ ! -f "$repo/CLAUDE.md" ]; then
  echo "@AGENTS.md" > "$repo/CLAUDE.md"
  echo "created  $repo/CLAUDE.md"
else
  grep -q "@AGENTS.md" "$repo/CLAUDE.md" || echo "note     add the line @AGENTS.md to $repo/CLAUDE.md"
fi
