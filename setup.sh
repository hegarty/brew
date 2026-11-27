#!/bin/bash
set -euo pipefail

# Settings
BASE_BRANCH="main"
BRANCH_NAME="update-brewfile-$(date +%Y%m%d-%H%M%S)"
BREWFILE="Brewfile"

# 0. Start from an up-to-date base branch
echo "Switching to $BASE_BRANCH and pulling latest..."
git checkout "$BASE_BRANCH"
git pull --ff-only origin "$BASE_BRANCH"

# 1. Refresh Brewfile
echo "Dumping current Brewfile..."
brew bundle dump --no-go --file="$BREWFILE" --force

# 2. Bail out before branching if nothing changed
if git diff --quiet -- "$BREWFILE"; then
  echo "No changes to commit. Exiting."
  exit 0
fi

# 3. Create new branch, stage and commit changes
git checkout -b "$BRANCH_NAME"
git add "$BREWFILE"
git commit -m "chore: update Brewfile with latest installed packages"

# 4. Push branch to origin
git push -u origin "$BRANCH_NAME"

# 5. Create PR with GitHub CLI
gh pr create \
  --title "chore: update Brewfile" \
  --body "This PR updates the Brewfile with the current state of installed packages via \`brew bundle dump\`." \
  --base "$BASE_BRANCH" \
  --head "$BRANCH_NAME"

# 6. Return to base branch
git checkout "$BASE_BRANCH"

echo "✅ Pull request created!"
