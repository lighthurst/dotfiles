#!/bin/bash

# Aaron's Dotfiles Installation Script
# This script sets up a new development environment with my preferred configurations

set -e

echo "🚀 Setting up Aaron's development environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Helper functions
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "📁 Dotfiles directory: $DOTFILES_DIR"

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
else
    print_warning "Oh My Zsh already installed"
fi

# Backup existing files
backup_file() {
    if [ -f "$1" ]; then
        cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Backed up existing $1"
    fi
}

# Symlink dotfiles
echo "🔗 Creating symlinks..."

# Shell configuration
backup_file "$HOME/.zshrc"
backup_file "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/shell/.zprofile" "$HOME/.zprofile"
print_success "Shell configuration linked"

# Git configuration (with user input)
if [ ! -f "$HOME/.gitconfig" ]; then
    echo "⚙️ Setting up Git configuration..."
    read -p "Enter your full name: " git_name
    read -p "Enter your email address: " git_email
    
    cp "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
    sed -i.bak "s/YOUR_NAME/$git_name/g" "$HOME/.gitconfig"
    sed -i.bak "s/YOUR_EMAIL/$git_email/g" "$HOME/.gitconfig"
    rm "$HOME/.gitconfig.bak"
    print_success "Git configuration set up"
else
    print_warning "Git configuration already exists, skipping"
fi

# VS Code configuration
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
if [ -d "$VSCODE_USER_DIR" ]; then
    echo "⚙️ Setting up VS Code configuration..."
    backup_file "$VSCODE_USER_DIR/settings.json"
    cp "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
    print_success "VS Code settings configured"
    
    # Install VS Code extensions
    if command -v code &> /dev/null; then
        echo "📦 Installing VS Code extensions..."
        while IFS= read -r extension; do
            code --install-extension "$extension" --force
        done < "$DOTFILES_DIR/vscode/extensions.txt"
        print_success "VS Code extensions installed"
    else
        print_warning "VS Code CLI not found. Install extensions manually from vscode/extensions.txt"
    fi
else
    print_warning "VS Code not found, skipping VS Code configuration"
fi

# Install Homebrew if not already installed (macOS)
if [[ "$OSTYPE" == "darwin"* ]] && ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew installed"
fi

echo ""
print_success "🎉 Dotfiles installation complete!"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Install your favorite apps with Homebrew"
echo "3. Customize further as needed"
echo ""
echo "Enjoy your new development environment! 🚀"
