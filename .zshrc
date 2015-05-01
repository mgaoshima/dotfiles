# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kolo"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=ja_JP.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias f="find . -name"
alias ga="git add -A; git status -s"
alias gs="git status -s"
alias reload="source ~/.zshrc"
alias diffcomp="git diff --exit-code --cached --name-only --diff-filter=ACM -- '*.png' '*.jpg' | imageoptim"
alias tarc="tar zcvf"
alias tarx="tar zxvf"
alias showhidden="defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder"
alias hidehidden="defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder"

alias chrome="open -a Google\ Chrome"
alias safari="open -a Safari"
alias prev="open -a Preview"
alias cot="open -a CotEditor"

alias vim="mvim -v"

# --------------------------------------
# 参考 https://github.com/uupaa/dotfiles/blob/master/.zshrc

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
alias rr='vi ~/.zshrc ~/.vimrc;rrr'
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

# ghq + peco ... http://qiita.com/strsk/items/9151cef7e68f0746820d
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
