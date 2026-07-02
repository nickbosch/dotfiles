function ghclone --description "Clone a GitHub repo by HTTPS URL via SSH into ~/github.com/<org>/<repo>"
    if test (count $argv) -ne 1
        echo "Usage: ghclone <https://github.com/org/repo>" >&2
        return 1
    end

    set -l url $argv[1]
    set -l repo_path (string replace -r '^https?://github\.com/' '' $url | string trim -r -c '/')
    set -l repo_path (string replace -r '\.git$' '' $repo_path)

    if not string match -qr '^[^/]+/[^/]+$' -- $repo_path
        echo "Not a valid GitHub repo URL: $url" >&2
        return 1
    end

    set -l org (string split '/' $repo_path)[1]
    set -l dest ~/github.com/$repo_path

    mkdir -p ~/github.com/$org
    git clone git@github.com:$repo_path.git $dest; and cd $dest
end
