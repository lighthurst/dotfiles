#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"
cd "$DOTFILES"

echo "Pulling latest changes..."
git pull --rebase

echo "Running install script..."
./scripts/install.sh

echo "Dotfiles updated!"
