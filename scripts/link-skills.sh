#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
skill_home="${CODEX_HOME:-$HOME/.codex}/skills"
mkdir -p "$skill_home"

linked=0
for skill_dir in "$repo_root"/skills/*; do
  [[ -d "$skill_dir" && -f "$skill_dir/SKILL.md" ]] || continue
  name="$(basename "$skill_dir")"
  target="$skill_home/$name"

  if [[ -e "$target" && ! -L "$target" ]]; then
    printf 'Refusing to replace existing directory: %s\n' "$target" >&2
    printf 'Move it aside first, then run this script again.\n' >&2
    exit 1
  fi

  if [[ -L "$target" ]]; then
    current_target="$(readlink "$target")"
    if [[ "$current_target" == "$skill_dir" ]]; then
      printf 'Already linked: %s\n' "$target"
      linked=$((linked + 1))
      continue
    fi
    rm "$target"
  fi

  ln -s "$skill_dir" "$target"
  printf 'Linked %s -> %s\n' "$target" "$skill_dir"
  linked=$((linked + 1))
done

if [[ "$linked" -eq 0 ]]; then
  printf 'No skill directories found under %s/skills\n' "$repo_root" >&2
  exit 1
fi
