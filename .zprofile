if [ -x "$(command -v brew)" ]; then
  eval "$(brew shellenv)"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ $TERM_PROGRAM = "WarpTerminal" ]]; then
  export STARSHIP_CONFIG=~/.config/starship.warp.toml
fi

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

