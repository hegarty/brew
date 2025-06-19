# Homebrew Dependency Management

A version-controlled approach to managing development tools and applications using Homebrew's bundle functionality.

## Overview

This repository contains a `Brewfile` that serves as a declarative manifest of all Homebrew-managed dependencies for my development environment. While this approach offers significant benefits for reproducibility and environment consistency, it also introduces the ongoing chore of maintenance and inventory management.

## The Benefits

### **Environment Reproducibility**
- **New Machine Setup**: Bootstrap a complete development environment with a single command
- **Consistent Tooling**: Ensure the same versions and tools across multiple machines
- **Team Alignment**: Share standardized toolsets with team members

### **Dependency Tracking**
- **Version Control**: Track changes to your toolset over time
- **Audit Trail**: See when tools were added, updated, or removed
- **Documentation**: Self-documenting list of required development tools

## The Chore

### 📝 **Ongoing Maintenance**
- **Regular Updates**: Keeping the Brewfile in sync with actual installed packages
- **Version Conflicts**: Managing compatibility between tools and their dependencies
- **Cleanup Overhead**: Removing unused or obsolete tools from the manifest
- **Documentation Debt**: Keeping track of why certain tools were added

## Alleviating the Chore: Automation with `setup.sh`

### 🤖 **The Solution**
The `setup.sh` script transforms the tedious manual maintenance process into a streamlined, automated workflow. Instead of remembering to manually sync your Brewfile, this script handles the entire update cycle with a single command.

### **What `setup.sh` Does**
1. **Captures Current State**: Runs `brew bundle dump` with descriptions to reflect your actual installed packages
2. **Creates a Feature Branch**: Automatically creates a timestamped branch for the changes
3. **Commits Changes**: Stages and commits the updated Brewfile with a standardized message
4. **Pushes to Remote**: Pushes the branch to your remote repository
5. **Creates Pull Request**: Uses GitHub CLI to create a PR with proper title and description

### **The Workflow Revolution**
```bash
# Old way: Multiple manual steps
brew bundle dump --force
git add Brewfile
git commit -m "Update brewfile"
git push
# Then manually create PR...

# New way: One command
./setup.sh
# ✅ Pull request created!
```

## Usage

### Initial Setup
```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Navigate to this directory
cd hegarty/brew

# Install all dependencies
brew bundle install
```

### Maintenance Operations

#### Automated Update (Recommended)
```bash
# Update Brewfile and create PR in one command
./setup.sh
```

#### Manual Update (Old School)
```bash
# Generate Brewfile from currently installed packages
brew bundle dump --force

# Review changes
git diff Brewfile

# Commit updates
git add Brewfile
git commit -m "Update Brewfile: add/remove tools"
```

#### Clean Install (Nuclear Option)
```bash
# Remove all Homebrew packages
brew bundle cleanup --force

# Reinstall from Brewfile
brew bundle install
```

#### Audit and Cleanup
```bash
# Check for packages not in Brewfile
brew bundle check

# List packages that would be removed
brew bundle cleanup --dry-run

# Actually remove unlisted packages
brew bundle cleanup
```
