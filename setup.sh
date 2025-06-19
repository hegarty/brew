#!/bin/bash
set -euo pipefail

# Settings
BRANCH_NAME="update-brewfile-$(date +%Y%m%d-%H%M%S)"
BREWFILE="Brewfile"

# 1. Refresh Brewfile
echo "Dumping current Brewfile..."
brew bundle dump --describe --file="$BREWFILE" --force

# 2. Create new branch
git checkout -b "$BRANCH_NAME"

# 3. Stage and commit changes
git add "$BREWFILE"
if git diff --cached --quiet; then
  echo "No changes to commit. Exiting."
  exit 0
fi
git commit -m "chore: update Brewfile with latest installed packages"

# 4. Push branch to origin
git push -u origin "$BRANCH_NAME"

# 5. Create PR with GitHub CLI
gh pr create \
  --title "chore: update Brewfile" \
  --body "This PR updates the Brewfile with the current state of installed packages via \`brew bundle dump\`." \
  --base main \
  --head "$BRANCH_NAME"

echo "✅ Pull request created!"

