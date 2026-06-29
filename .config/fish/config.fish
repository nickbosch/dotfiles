# homebrew
eval (/opt/homebrew/bin/brew shellenv)

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

# Git
abbr -a -- gcv! git commit -v --no-verify --amend
abbr -a -- gcv!! git commit -v --no-verify --amend --no-edit
abbr -a -- gcav!! git commit -a -v --no-verify --amend --no-edit
abbr -a -- gfrp 'git fetch && git rebase origin/main && git push --force-with-lease'

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
set -gx PNPM_HOME "~/Library/pnpm"
fish_add_path $PNPM_HOME
# pnpm end

fish_add_path $HOME/.local/bin
