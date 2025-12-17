#!/bin/bash
# Minimal dotfiles setup for remote servers
# Usage: curl -fsSL <raw-url>/server/setup.sh | bash

set -e

REPO_URL="https://raw.githubusercontent.com/lighthurst/dotfiles/main/server"

echo "Setting up server dotfiles..."

# Backup existing files
for file in .vimrc .gitconfig; do
  if [ -f "$HOME/$file" ]; then
    mv "$HOME/$file" "$HOME/$file.bak"
    echo "Backed up existing $file to $file.bak"
  fi
done

# Download configs
curl -fsSL "$REPO_URL/.vimrc" -o "$HOME/.vimrc"
curl -fsSL "$REPO_URL/.gitconfig" -o "$HOME/.gitconfig"

echo ""

# Configure git identity (read from /dev/tty for curl pipe compatibility)
if [ -t 0 ] || [ -e /dev/tty ]; then
  echo "Configure git identity:"
  read -p "Enter your full name: " git_name < /dev/tty
  read -p "Enter your email address: " git_email < /dev/tty

  git config --global user.name "$git_name"
  git config --global user.email "$git_email"

  echo ""
  echo "Done! Git configured as: $git_name <$git_email>"
else
  echo "Done! Configure git identity:"
  echo "  git config --global user.name \"Your Name\""
  echo "  git config --global user.email \"you@example.com\""
fi
