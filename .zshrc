# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Spaceship prompt
SPACESHIP_DIR_TRUNC=0
SPACESHIP_PROMPT_ORDER=(
    time          # Time stampts section
    user          # Username section
    dir           # Current directory section
    host          # Hostname section
    git           # Git section (git_branch + git_status)
    hg            # Mercurial section (hg_branch  + hg_status)
    # package       # Package version
    # node          # Node.js section
    # ruby          # Ruby section
    # elm           # Elm section
    # elixir        # Elixir section
    # xcode         # Xcode section
    # swift         # Swift section
    # golang        # Go section
    # php           # PHP section
    # rust          # Rust section
    # haskell       # Haskell Stack section
    # julia         # Julia section
    # docker        # Docker section
    # aws           # Amazon Web Services section
    # gcloud        # Google Cloud Platform section
    # venv          # virtualenv section
    # conda         # conda virtualenv section
    # pyenv         # Pyenv section
    # dotnet        # .NET section
    # ember         # Ember.js section
    # kubectl       # Kubectl context section
    # terraform     # Terraform workspace section
    exec_time     # Execution time
    line_sep      # Line break
    battery       # Battery level and status
    vi_mode       # Vi-mode indicator
    jobs          # Background jobs indicator
    exit_code     # Exit code section
    char          # Prompt character
  )

# asdf version manager
. $(brew --prefix asdf)/libexec/asdf.sh

# custom env vars
export PATH="$HOME/bin:$PATH"
export EDITOR=vim
export DOCKER_HIDE_LEGACY_COMMANDS=true

# start gpg-agent
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# direnv hook
eval "$(direnv hook zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load aliases
[ -f ~/.aliases ] && source ~/.aliases

# load functions
[ -f ~/.functions ] && source ~/.functions