# Alias
alias gs="git status -s"
alias ga="git add -A; gs"
alias tarc="tar zcvf"
alias tarx="tar zxvf"
alias rsync="rsync --exclude-from=$HOME/.rsync_excludes"
alias diffcomp="git diff --exit-code --cached --name-only --diff-filter=ACM -- '*.png' '*.jpg' | imageoptim"

# Golang
set -x GOPATH $HOME/Workspace
set -x PATH $PATH $GOPATH/bin

# ghq + fzf ... http://qiita.com/unlovingly/items/99999271df7eea7bc953
function fzf_select_repository
  ghq list -p | fzf | read repo
  if test $repo
    builtin cd $repo
  end
  commandline -f repaint
end

# key bindings
function fish_user_key_bindings
  bind \c] fzf_select_repository
  # etc...

end
