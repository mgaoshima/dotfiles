#!/bin/sh


# dotfiles
git clone git@github.com:nzmosh/dotfiles.git ~/dotfiles

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install vim --with-lua
brew install macvim --with-cscope --with-lua --HEAD
brew install git node ack tree nkf lv

# NeoBundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

# Oh My Zsh - https://github.com/robbyrussell/oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global

# :NeoBundleInstall を実行 http://qiita.com/yoan/items/6216646324f68e54809d
vim +":NeoBundleInstall" +:q

