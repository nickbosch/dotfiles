# homebrew
eval (/opt/homebrew/bin/brew shellenv)

# asdf-vm
source (brew --prefix)/opt/asdf/libexec/asdf.fish

# direnv
direnv hook fish | source

# zoxide
zoxide init fish | source

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
end

