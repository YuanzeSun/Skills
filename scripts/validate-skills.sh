#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
validator="${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-creator/scripts/quick_validate.py"

if [[ ! -f "$validator" ]]; then
  printf 'Validator not found: %s\n' "$validator" >&2
  exit 1
fi

found=0
for skill_dir in "$repo_root"/skills/*; do
  [[ -d "$skill_dir" && -f "$skill_dir/SKILL.md" ]] || continue
  found=1
  printf '\nValidating %s\n' "$(basename "$skill_dir")"
  python3 "$validator" "$skill_dir"
done

if [[ "$found" -eq 0 ]]; then
  printf 'No skill directories found under %s/skills\n' "$repo_root" >&2
  exit 1
fi
