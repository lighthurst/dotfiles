# Homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  # Apple Silicon (preferred)
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  # Intel fallback
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Limit auto-update to once per day (default: 5 min)
export HOMEBREW_AUTO_UPDATE_SECS=86400
