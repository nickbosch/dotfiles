# homebrew
if test -e /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
else
    eval (/usr/local/bin/brew shellenv)
end

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

abbr -a -- dacl git\ log\ --oneline\ --no-decorate\ \|\ awk\ \'/release:/\ \{exit\}\ \{print\ \"-\ \"\ \$0\}\'
