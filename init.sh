#!/bin/bash


function brew_install () {
  if [ `brew list | grep -x $1` ]; then
    echo "Formula already insatlled: ${1}";
  else
    echo "Brewing ${*}..."
    brew install $*
  fi
}

function brew_cask_install () {
  if [ `brew cask list | grep $1` ]; then
    echo "Cask already insatlled: ${1}";
  else
    echo "Brewing ${*}..."
    brew cask install $*
  fi
}

function brew_tap () {
  if [ `brew tap | grep -x $1` ]; then
    echo "${1} already tapped";
  else
    echo "Tapping ${*}..."
    brew tap $*
  fi
}

function npm_install () {
  if [ `npm list --depth=0 -g --parseable | grep "${1}$"` ]; then
    echo "Package already installed: ${1}";
  else
    npm install $*
  fi
}

function gem_install () {
  if [ `gem list --local --no-versions | grep -x $1` ]; then
    echo "Gem already installed: ${1}";
  else
    sudo gem install $*
  fi
}


# Xcode Command Line Tools
if [ `which gcc` ]; then
  echo "Xcode Command Line Tools already installed."
else
  xcode-select --install
fi

# Homebrew
if [ `which brew` ]; then
  echo "Homebrew already installed."
else
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "Installing Homebrew Cask..."
  brew install caskroom/cask/brew-cask
fi

brew_install ack
brew_install brew-cask
brew_install git
brew_install git-lfs
brew_install go
brew_install heroku-toolbelt
brew_install hub
brew_install hugo
brew_install libpng
brew_install lv
brew_install macvim --override-system-vim --with-cscope --with-lua --custom-icons && brew linkapps macvim
brew_tap motemen/ghq && brew_install ghq
brew_install nkf
brew_install node
brew_tap peco/peco && brew_install peco
brew_install tree

# Cask ~
brew_cask_install appcleaner
brew_cask_install atom
brew_cask_install coteditor
brew_cask_install firefox
brew_cask_install google-chrome
brew_cask_install google-drive
brew_cask_install imageoptim
brew_cask_install integrity
brew_cask_install kaleidoscope
brew_cask_install keka
brew_cask_install gyazo
brew_cask_install macwinzipper
brew_cask_install name-mangler
brew_cask_install qlmarkdown
brew_cask_install sourcetree
brew_cask_install the-unarchiver
brew_cask_install transmit
brew_cask_install versions

# Cask /
brew_cask_install adobe-creative-cloud
brew_cask_install google-japanese-ime
brew_cask_install virtualbox

# npm
if [ `which npm` ]; then
  npm_install browser-sync -g
  npm_install divshot-cli -g
  npm_install imageoptim-cli -g
  npm_install grunt-cli -g
fi

# Ruby Gems
if [ `which gem` ]; then
  gem_install foreman
  gem_install git-up
  gem_install jekyll
fi



# Oh My Zsh - https://github.com/robbyrussell/oh-my-zsh
if [ -e ~/.oh-my-zsh ]; then
  echo "oh-my-zsh already installed."
else
  curl -L http://install.ohmyz.sh | sh
fi


# link dotfiles
echo "Linking dotfiles..."
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global



# NeoBundle - http://qiita.com/yoan/items/6216646324f68e54809d
if [ -e ~/.vim/bundle/neobundle.vim ]; then
  echo "NeoBundle already installed."
else
  echo "Installing NeoBundle..."
  curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
  vim +":NeoBundleInstall" +:q
fi
