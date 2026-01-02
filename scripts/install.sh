#!/bin/bash

# Dotfiles Installation Script
# Sets up a new development environment with preferred configurations

set -e

# Get user's name for personalized messages
if [[ "$OSTYPE" == "darwin"* ]]; then
  USER_NAME=$(id -F 2>/dev/null || echo "$USER")
else
  USER_NAME=$(getent passwd "$USER" 2>/dev/null | cut -d: -f5 | cut -d, -f1 || echo "$USER")
fi

echo "🚀 Setting up ${USER_NAME}'s development environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Helper UI functions
print_success() { echo -e "${GREEN}✓${NC} $1"; }
print_warning() { echo -e "${YELLOW}⚠${NC} $1"; }
print_error() { echo -e "${RED}✗${NC} $1"; }

# Resolve repo root
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
echo "📁 Dotfiles directory: $DOTFILES_DIR"

#
# Backup helper — only backs up if target differs from source
#
backup_if_different() {
  local target="$1"
  local source="$2"
  if [ -e "$target" ] || [ -L "$target" ]; then
    # For symlinks, check if already pointing to correct source
    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
      print_success "Skipped backup of $target (symlink already correct)"
      return 0
    fi
    # For files, check if content differs
    if ! cmp -s "$target" "$source" 2>/dev/null; then
      cp -L "$target" "$target.backup.$(date +%Y%m%d_%H%M%S)"
      print_warning "Backed up existing $target"
    else
      print_success "Skipped backup of $target (already matches source)"
    fi
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
backup_if_different "$HOME/.zshrc" "$DOTFILES_DIR/shell/.zshrc"
backup_if_different "$HOME/.zprofile" "$DOTFILES_DIR/shell/.zprofile"

ln -sf "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/shell/.zprofile" "$HOME/.zprofile"

print_success "Shell configuration linked"

#
# SSH configuration (1Password SSH Agent)
#
OP_AGENT_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

if [ -S "$OP_AGENT_SOCK" ]; then
  echo "🔗 Setting up SSH configuration..."
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"

  backup_if_different "$HOME/.ssh/config" "$DOTFILES_DIR/ssh/config"
  ln -sf "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
  chmod 600 "$HOME/.ssh/config"
  touch "$HOME/.ssh/config.local"
  chmod 600 "$HOME/.ssh/config.local"

  print_success "SSH configuration linked (using 1Password SSH Agent)"
else
  print_warning "1Password SSH Agent not detected — skipping SSH config"
fi

#
# Git configuration
#
echo "🔗 Setting up Git configuration..."
backup_if_different "$HOME/.gitconfig" "$DOTFILES_DIR/git/.gitconfig"
ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
print_success "Git configuration linked"

if [ ! -f "$HOME/.gitconfig.local" ]; then
  echo "⚙️ Creating local Git configuration..."
  read -p "Enter your full name: " git_name
  read -p "Enter your email address: " git_email

  cat > "$HOME/.gitconfig.local" <<EOF
[user]
  name = $git_name
  email = $git_email
EOF
  print_success "Local Git configuration created at ~/.gitconfig.local"
else
  print_warning "Local Git configuration already exists, skipping"
fi

#
# VS Code configuration
#
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"

if [ -d "$VSCODE_USER_DIR" ]; then
  echo "⚙️ Setting up VS Code configuration..."
  if ! cmp -s "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"; then
    backup_if_different "$VSCODE_USER_DIR/settings.json" "$DOTFILES_DIR/vscode/settings.json"
    cp "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
    print_success "VS Code settings updated"
  else
    print_warning "VS Code settings already up to date"
  fi

  if command -v code &> /dev/null; then
    echo "📦 Installing VS Code extensions..."
    while IFS= read -r ext; do
      # skip blank lines and comments
      ext="${ext%%#*}"
      ext="${ext#"${ext%%[![:space:]]*}"}"
      ext="${ext%"${ext##*[![:space:]]}"}"
      [[ -z "$ext" ]] && continue

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

if command -v brew &> /dev/null && [ -f "$DOTFILES_DIR/Brewfile" ]; then
  echo "📦 Installing Homebrew packages from Brewfile..."
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  print_success "Homebrew packages installed"
fi

#
# Vim configuration
#
echo "🔗 Linking Vim configuration..."

backup_if_different "$HOME/.vimrc" "$DOTFILES_DIR/vim/.vimrc"

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
# Neovim configuration
#
echo "🔗 Linking Neovim configuration..."

mkdir -p "$HOME/.config"
backup_if_different "$HOME/.config/nvim" "$DOTFILES_DIR/nvim"

ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
print_success "Neovim configuration linked"

#
# Global gitignore
#
echo "🔗 Setting up global gitignore..."
GLOBAL_IGNORE="$HOME/.gitignore_global"
DOTFILES_IGNORE="$DOTFILES_DIR/git/gitignore_global"

touch "$GLOBAL_IGNORE"

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" || "$line" =~ ^# ]] && continue
  grep -qxF "$line" "$GLOBAL_IGNORE" || echo "$line" >> "$GLOBAL_IGNORE"
done < "$DOTFILES_IGNORE"

print_success "Global gitignore configured"

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
