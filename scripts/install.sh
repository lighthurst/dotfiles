#!/bin/bash

# Aaron's Dotfiles Installation Script
# Sets up a new development environment with preferred configurations

set -e

echo "🚀 Setting up Aaron's development environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Helper UI functions
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error()   { echo -e "${RED}✗${NC} $1"; }

# Resolve repo root
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "📁 Dotfiles directory: $DOTFILES_DIR"

#
# Backup helper — handles files OR symlinks safely
#
backup_file() {
    if [ -e "$1" ] || [ -L "$1" ]; then
        cp -L "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
        print_warning "Backed up existing $1"
    fi
}

#
# Install Oh My Zsh (unattended)
#
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "📦 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh My Zsh installed"
else
    print_warning "Oh My Zsh already installed"
fi

#
# Shell configuration
#
echo "🔗 Creating symlinks for shell configuration..."
backup_file "$HOME/.zshrc"
backup_file "$HOME/.zprofile"

ln -sf "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/shell/.zprofile" "$HOME/.zprofile"

print_success "Shell configuration linked"

#
# Git configuration
#
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

#
# VS Code configuration
#
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

if [ -d "$VSCODE_USER_DIR" ]; then
    echo "⚙️ Setting up VS Code configuration..."
    backup_file "$VSCODE_USER_DIR/settings.json"
    cp "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
    print_success "VS Code settings configured"

    if command -v code &> /dev/null; then
        echo "📦 Installing VS Code extensions..."
        while IFS= read -r ext; do
            code --install-extension "$ext" --force
        done < "$DOTFILES_DIR/vscode/extensions.txt"
        print_success "VS Code extensions installed"
    else
        print_warning "VS Code CLI not found — skipping extension install"
    fi
else
    print_warning "VS Code not detected — skipping VS Code configuration"
fi

#
# Homebrew installation
#
if [[ "$OSTYPE" == "darwin"* ]] && ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew installed"
fi

#
# Vim configuration
#
echo "🔗 Linking Vim configuration..."

backup_file "$HOME/.vimrc"

ln -sf "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
print_success "Vim configuration linked"

# Install vim-plug if missing
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "📦 Installing vim-plug plugin manager..."
    curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    print_success "vim-plug installed"
else
    print_warning "vim-plug already installed"
fi

# Install Vim plugins
echo "📦 Installing Vim plugins (via vim-plug)..."
vim +PlugInstall +qall || print_warning "Vim plugin installation skipped (non-fatal)"

print_success "Vim setup complete"

#
# Final messages
#
echo ""
print_success "🎉 Dotfiles installation complete!"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.zshrc"
echo "2. Confirm Vim plugins loaded: vim → :PlugStatus"
echo "3. Enjoy your fully configured environment 🚀"
echo ""
