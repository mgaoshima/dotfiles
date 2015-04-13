#!/bin/sh


# dotfiles
git clone git@github.com:mgaoshima/dotfiles.git ~/dotfiles

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install vim --with-lua
brew install macvim --with-cscope --with-lua --HEAD
brew install\
  ack\
  git\
  go\
  heroku-toolbelt\
  hub\
  lv\
  nkf\
  node\
  tree\

brew install caskroom/cask/brew-cask
brew cask install\
  adobe-creative-cloud\
  appcleaner\
  coteditor\
  firefox\
  google-chrome\
  google-drive\
  google-japanese-ime\
  imageoptim\
  integrity\
  kaleidoscope\
  keka\
  macwinzipper\
  mamp\
  miro-video-converter\
  mou\
  name-mangler\
  qlmarkdown\
  the-unarchiver\
  transmit\
  versions\
  virtualbox\

brew cask cleanup

open /opt/homebrew-cask/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app

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

