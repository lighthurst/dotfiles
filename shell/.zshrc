# ============================================================
# Oh My Zsh core setup
# ============================================================

export ZSH="$HOME/.oh-my-zsh"

# Prompt theme (change anytime: bira, half-life, af-magic, etc.)
ZSH_THEME="robbyrussell"

# ------------------------------------------------------------
# Zsh / Oh My Zsh options (must be set before sourcing OMZ)
# ------------------------------------------------------------

# Treat hyphens and underscores as equivalent during completion.
HYPHEN_INSENSITIVE="true"

# Auto-correct mistyped commands (disable if it feels annoying).
ENABLE_CORRECTION="true"

# Remind to update Oh My Zsh occasionally (not auto-update).
zstyle ':omz:update' mode 'reminder'
zstyle ':omz:update' frequency 13

# Speed up git prompt for huge repos (optional).
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins: keep list short for fast startup.
plugins=(
  git
)

# Load Oh My Zsh.
source "$ZSH/oh-my-zsh.sh"

# ============================================================
# Environment
# ============================================================

# Keep PATH entries unique (zsh treats $path as an array).
typeset -U path PATH

# Default editor for CLI tools.
export EDITOR="vim"
export VISUAL="vim"

# If later you prefer neovim locally but vim on SSH hosts:
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
#   export VISUAL='vim'
# else
#   export EDITOR='nvim'
#   export VISUAL='nvim'
# fi

# Optional: set locale explicitly.
# export LANG="en_US.UTF-8"

# Optional: show timestamps in `history`.
# HIST_STAMPS="yyyy-mm-dd"

# direnv: auto-load .envrc files per directory
if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi

# 1Password SSH Agent
if [ -S "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi

# ============================================================
# Aliases
# ============================================================

# Compact colored git log with author plus relative time.
alias glp='git log --pretty=format:"%C(yellow)%h%Creset - %C(green)%an%Creset, %ar : %s"'

# Update dotfiles from remote and re-run install.
alias dotup="~/dotfiles/scripts/update.sh"

# Example convenience aliases:
# alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="vim ~/.oh-my-zsh"

# ============================================================
# Machine-specific overrides (not tracked in dotfiles repo)
# ============================================================
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
