function git-ticket-branch
    read -P "Enter ticket number: " ticket
    read -P "Enter branch description: " description
    set -l branch (slugify $description)
    git checkout -b "nick/$ticket/$branch"
end
