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
abbr -a -- gstau git stash --include-untracked
abbr -a -- c code
abbr -a -- c. code .

# GitHub CLI
abbr -a -- prco gh pr checkout
abbr -a -- prls gh pr list
abbr -a -- prrv gh pr review
abbr -a -- prap gh pr review --approve
abbr -a -- prcr gh pr create
abbr -a -- prcrw gh pr create --web
abbr -a -- prv gh pr view
abbr -a -- prvw gh pr view --web

# pnpm
abbr -a -- pnpmr pnpm recursive

function lgtm
  set -f emoji (node -e 'console.log(["👍","🙌","🚀","🚢","👌","✅"][Math.floor(Math.random()*6)])')
  gh pr review --approve --body "LGTM $emoji" $argv
end

# pnpm
set -gx PNPM_HOME "/Users/nickbosch/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
