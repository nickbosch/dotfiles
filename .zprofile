# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# mise en place
eval "$(mise activate zsh --shims)"

export PATH="$HOME/.local/bin:$PATH"
