# Homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  # Apple Silicon (preferred)
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  # Intel fallback
  eval "$(/usr/local/bin/brew shellenv)"
fi
