#!/usr/bin/env bash
# Set up estack in Codex.
# Usage: scripts/codex-setup.sh <personal|work|both>
# Installs core plus the chosen plugins from the estack marketplace, then
# copies core's rules.md into Codex's global AGENTS.md between markers.
# Run it again after estack changes. Set ESTACK_SOURCE to use a local clone.
set -euo pipefail

case "${1:-}" in
  personal) plugins="core personal" ;;
  work) plugins="core work" ;;
  both) plugins="core personal work" ;;
  *) echo "usage: $0 <personal|work|both>" >&2; exit 1 ;;
esac
command -v codex >/dev/null || { echo "codex is not installed or not on PATH" >&2; exit 1; }

source="${ESTACK_SOURCE:-agustinkiko/estack}"
codex_home="${CODEX_HOME:-$HOME/.codex}"
run() { "$@" 2>&1 | grep -v '^WARNING:' || true; }

run codex plugin marketplace add "$source"
[ -d "$source" ] || run codex plugin marketplace upgrade estack

core_root=""
for plugin in $plugins; do
  out="$(run codex plugin add "$plugin@estack")"
  echo "$out"
  if [ "$plugin" = core ]; then
    core_root="$(echo "$out" | sed -n 's/^Installed plugin root: //p' | tail -1)"
  fi
done

rules="$core_root/rules.md"
[ -f "$rules" ] || { echo "could not find rules.md under '$core_root'" >&2; exit 1; }

start="<!-- estack:start. Generated from estack plugins/core/rules.md by scripts/codex-setup.sh. Do not edit. Rerun the script. -->"
end="<!-- estack:end -->"
agents="$codex_home/AGENTS.md"
mkdir -p "$codex_home"
touch "$agents"

kept="$(awk -v end="$end" '
  index($0, "<!-- estack:start") == 1 { skip = 1; next }
  skip && $0 == end { skip = 0; next }
  !skip { print }
' "$agents")"

{
  if [ -n "$kept" ]; then printf '%s\n\n' "$kept"; fi
  echo "$start"
  cat "$rules"
  echo "$end"
} > "$agents.tmp"
mv "$agents.tmp" "$agents"
echo "updated  $agents"
