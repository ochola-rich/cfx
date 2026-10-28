#!/usr/bin/env bash
set -euo pipefail

DIR="/home/richie/go/cfx/issues/phase-5-hardening"
TMPBODY="/tmp/issue_body.md"
MILESTONE="Phase 5: Hardening"

mapfile -t files < <(ls "$DIR"/*.md | sort)

for file in "${files[@]}"; do
  echo "Processing $file"
  title=$(grep -m1 '^# ' "$file" | sed 's/^# //')
  clean_title=${title#"[Phase 5] "}
  labels_line=$(grep '^\*\*Labels:\*\*' "$file" || true)
  labels=()
  if [[ -n "$labels_line" ]]; then
    mapfile -t labels < <(python3 -c "
import re, sys
txt=sys.argv[1]
for m in re.finditer(r'\`([^\`]+)\`', txt):
    print(m.group(1))
" "$labels_line")
  fi
  body=$(sed -n '/^---$/,${//!p}' "$file" | sed '1d')
  printf "%s\n" "$body" > "$TMPBODY"
  cmd=(gh issue create --repo ochola-rich/cfx --title "$clean_title" --body-file "$TMPBODY" --milestone "$MILESTONE")
  for lbl in "${labels[@]}"; do
    cmd+=(--label "$lbl")
  done
  echo "Creating issue: $clean_title"
  "${cmd[@]}"
done