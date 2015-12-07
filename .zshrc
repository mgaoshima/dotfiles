#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...


# --------------------------------------
# 参考 https://github.com/uupaa/dotfiles/blob/master/.zshrc


alias f="find . -name"
alias ga="git add -A; git status -s"
alias gs="git status -s"
alias reload="source ~/.zshrc"
alias diffcomp="git diff --exit-code --cached --name-only --diff-filter=ACM -- '*.png' '*.jpg' | xargs imageoptim"
alias tarc="tar zcvf"
alias tarx="tar zxvf"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder"

alias chrome="open -a Google\ Chrome"
alias safari="open -a Safari"
alias prev="open -a Preview"
alias cot="open -a CotEditor"

alias mvim="vim"

# スペルミス補完
setopt correct

# 補完される前にオリジナルのコマンドまで展開してチェックする
setopt complete_aliases

# 余分な空白は詰めて登録(空白数違い登録を防ぐ)
setopt hist_reduce_blanks

# カレントディレクトリ中にサブディレクトリが
# 見付からなかった場合に cd が検索するディレクトリのリスト
cdpath=($HOME)

# edit and reload resource files: 設定ファイル(zshrc, vimrc)編集用
alias rr='vi ~/.vimrc ~/.zshrc ~/.zpreztorc;rrr'
function rrr() {
  source ${HOME}/.zshrc
}

# Go
export GOPATH=$HOME/Workspace
export PATH=$PATH:$GOPATH/bin

# GitHub
eval "$(hub alias -s)"

# boot2docker
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/nozomi/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

function update-shell () {
  git --git-dir=${ZDOTDIR:-$HOME}/.zprezto/.git --work-tree=${ZDOTDIR:-$HOME}/.zprezto pull \
    && git --git-dir=${ZDOTDIR:-$HOME}/.zprezto/.git --work-tree=${ZDOTDIR:-$HOME}/.zprezto submodule update --init --recursive
}

# ghq + peco ... http://qiita.com/strsk/items/9151cef7e68f0746820d
function peco-src () {
  local selected_dir=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd $GOPATH/src/${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-finder () {
  local selected_dir=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="open $GOPATH/src/${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-finder
bindkey '^_' peco-finder


#  # 作業中のリポジトリを表示
#  wipdir=`gch -l`
#  if [ -n "$wipdir" ]; then
#    echo -e "Dirty working trees:"
#    echo "$wipdir"
#  fi


# 256color-term
export TERM=xterm-256color

# Linuxbrew
if [ -e $HOME/.linuxbrew ]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
  export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
  export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"
fi

# MySQL
export PATH=$PATH:/usr/local/mysql/bin
