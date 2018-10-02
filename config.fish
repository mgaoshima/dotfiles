# Alias
alias gs="git status -s"
alias ga="git add -A; gs"
alias tarc="tar zcvf"
alias tarx="tar zxvf"
alias rsync="rsync -zh --exclude-from=$HOME/.rsync_excludes"
#alias diffcomp="git diff --relative --exit-code --cached --name-only --diff-filter=ACM -- '*.png' '*.jpg' | imageoptim"
alias diffcomp_imagealpha="git diff --relative --exit-code --cached --name-only --diff-filter=ACM -- '*.png' | xargs pngquant --force --ext .png"
alias diffcomp_imageoptim="git diff --relative --exit-code --cached --name-only --diff-filter=ACM -- '*.png' '*.jpg' | xargs imageoptim"
alias diffcomp="diffcomp_imagealpha; diffcomp_imageoptim"

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


# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

function fish_prompt
  set last_status $status
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal
  printf '%s ' (__fish_git_prompt)
  set_color normal
end
