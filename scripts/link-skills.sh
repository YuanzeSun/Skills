#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
skill_home="${CODEX_HOME:-$HOME/.codex}/skills"
enabled_file="$repo_root/enabled-skills.txt"

if [[ ! -f "$enabled_file" ]]; then
  printf 'Enabled skill list not found: %s\n' "$enabled_file" >&2
  exit 1
fi

mkdir -p "$skill_home"

linked=0
while IFS= read -r name || [[ -n "$name" ]]; do
  [[ -z "$name" || "$name" == \#* ]] && continue
  skill_dir="$repo_root/skills/$name"

  if [[ ! -d "$skill_dir" || ! -f "$skill_dir/SKILL.md" ]]; then
    printf 'Enabled skill is missing: %s\n' "$skill_dir" >&2
    exit 1
  fi

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
done < "$enabled_file"

if [[ "$linked" -eq 0 ]]; then
  printf 'No enabled skills found in %s\n' "$enabled_file" >&2
  exit 1
fi
