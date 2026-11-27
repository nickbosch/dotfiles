function lgtm --description "Approve the current PR with a random LGTM emoji"
    set -l emoji (random choice 👍 🙌 🚀 🚢 👌 ✅)
    gh pr review --approve --body "LGTM $emoji" $argv
end
