#!/bin/sh


# dotfiles
git clone git@github.com:mgaoshima/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask
brew update && brew cask update

brew install ack
#brew install autoconf
brew install boot2docker
brew install brew-cask
brew install git
brew install go
brew install heroku-toolbelt
brew install hub
#brew install libpng
brew install lv
brew install macvim --override-system-vim --with-cscope --with-lua --custom-icons && brew linkapps macvim
brew install mercurial
brew install nkf
brew install node
#brew install python
brew install tree
brew cask install adobe-creative-cloud
brew cask install appcleaner
#brew cask install atom
brew cask install coteditor
#brew cask install firefox
brew cask install google-chrome
brew cask install google-drive
brew cask install google-japanese-ime
brew cask install imageoptim
#brew cask install integrity
brew cask install kaleidoscope
#brew cask install keka
brew cask install macwinzipper
#brew cask install mamp
#brew cask install miro-video-converter
#brew cask install mou
brew cask install name-mangler
brew cask install qlmarkdown
brew cask install the-unarchiver
brew cask install transmit
#brew cask install versions
brew cask install virtualbox


# npm
npm install -g browser-sync
npm install -g divshot-cli
npm install -g imageoptim-cli
npm install -g grunt-cli


# Oh My Zsh - https://github.com/robbyrussell/oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh


# link dotfiles
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global


# NeoBundle - http://qiita.com/yoan/items/6216646324f68e54809d
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
vim +":NeoBundleInstall" +:q

# CreativeCloudをインストール
open /opt/homebrew-cask/Caskroom/adobe-creative-cloud/latest/Creative\ Cloud\ Installer.app

