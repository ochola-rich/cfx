#!/usr/bin/env bash
set -euo pipefail

# sync-github-issues.sh
# Creates all 71 issues in GitHub repo using the 'gh' CLI tool.

REPO="${GITHUB_REPOSITORY:-}"
if [ -z "$REPO" ]; then
  REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "")
fi

if [ -z "$REPO" ]; then
  echo "Error: Could not determine GitHub repository. Ensure 'gh' is authenticated or set GITHUB_REPOSITORY."
  exit 1
fi

echo "Repository target: $REPO"
read -p "Do you want to create all 71 issues in $REPO now? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Aborted by user."
  exit 0
fi

create_issue() {
  local file="$1"
  local title
  title=$(grep -m1 '^# ' "$file" | sed 's/^# //')
  local labels
  labels=$(grep -m1 '^\*\*Labels:\*\*' "$file" | sed 's/\*\*Labels:\*\* //' | tr -d '`' | tr -d ' ')
  
  echo "Creating issue: $title..."
  gh issue create \
    --repo "$REPO" \
    --title "$title" \
    --body-file "$file" \
    --label "$labels" || {
      # Fallback if labels don't exist yet
      echo "Retrying without labels in case labels do not exist..."
      gh issue create --repo "$REPO" --title "$title" --body-file "$file"
    }
}

for issue_file in issues/phase-*/*.md; do
  if [ -f "$issue_file" ]; then
    create_issue "$issue_file"
    sleep 1 # Throttle to prevent secondary rate limits
  fi
done

echo "All issues created successfully!"
