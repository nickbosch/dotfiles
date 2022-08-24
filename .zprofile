if [ -x "$(command -v brew)" ]; then
  eval "$(brew shellenv)"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

