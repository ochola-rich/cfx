#!/usr/bin/env bash
set -euo pipefail

DIR="/home/richie/go/cfx/issues/phase-1-language"
mapfile -t files < <(ls "$DIR"/*.md | sort)

# Issues were created starting at #2
issue_num=2
for file in "${files[@]}"; do
  title=$(grep -m1 '^# ' "$file" | sed 's/^# //')
  # Remove leading "[Phase 1] " if present
  clean_title=${title#"[Phase 1] "}
  echo "Editing issue #$issue_num -> $clean_title"
  gh issue edit "$issue_num" --repo ochola-rich/cfx --title "$clean_title"
  ((issue_num++))
done