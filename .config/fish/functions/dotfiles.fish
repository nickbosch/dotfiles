function dotfiles --wraps='/usr/bin/git --git-dir=/Users/nickbosch/.dotfiles --work-tree=/Users/nickbosch' --description 'alias dotfiles=/usr/bin/git --git-dir=/Users/nickbosch/.dotfiles --work-tree=/Users/nickbosch'
  /usr/bin/git --git-dir=/Users/nickbosch/.dotfiles --work-tree=/Users/nickbosch $argv; 
end
