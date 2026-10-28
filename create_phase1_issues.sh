#!/usr/bin/env bash
set -euo pipefail

DIR="/home/richie/go/cfx/issues/phase-1-language"
TMPBODY="/tmp/issue_body.md"

for file in "$DIR"/*.md; do
  # sort by name (lexicographic works for zero-padded numbers)
  :
done

# Use array to ensure sorted
mapfile -t files < <(ls "$DIR"/*.md | sort)

for file in "${files[@]}"; do
  echo "Processing $file"
  # Extract title (first # line)
  title=$(grep -m1 '^# ' "$file" | sed 's/^# //')
  # Extract labels line
  labels_line=$(grep '^\*\*Labels:\*\*' "$file" || true)
  labels=()
  if [[ -n "$labels_line" ]]; then
    # extract backticked words
    while [[ "$labels_line" =~ \`([^\`]+)\` ]]; do
      labels+=("${BASH_REMATCH[1]}")
      labels_line=${labels_line#*"${BASH_REMATCH[0]}"}
    done
  fi
  # Body: everything after the first '---' line
  body=$(sed -n '/^---$/,${//!p}' "$file" | sed '1d')
  # Write body to temp file
  printf "%s\n" "$body" > "$TMPBODY"
  # Build gh command
  cmd=(gh issue create --repo ochola-rich/cfx --title "$title" --body-file "$TMPBODY")
  for lbl in "${labels[@]}"; do
    cmd+=(--label "$lbl")
  done
  echo "Creating issue: $title"
  "${cmd[@]}"
done