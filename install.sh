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
brew_install android-platform-tools
brew_install cmake
brew_install fish
brew_install git
brew_install go
brew_install libpng
brew_install lv
brew_install nkf
brew_install node
brew_install tree
brew_install htop
brew_install vim --override-system-vi --with-lua
brew_install wget
brew_install youtube-dl
brew_install translate-shell
brew_tap motemen/ghq && brew_install ghq

# Cask ~
brew_cask_install adobe-creative-cloud
brew_cask_install appcleaner
brew_cask_install imageoptim
brew_cask_install integrity
brew_cask_install kaleidoscope
brew_cask_install keka
brew_cask_install macwinzipper
brew_cask_install name-mangler
brew_cask_install qlcolorcode
brew_cask_install qlimagesize
brew_cask_install qlmarkdown
brew_cask_install qlstephen
brew_cask_install quicklook-csv
brew_cask_install quicklook-json
brew_cask_install sourcetree
brew_cask_install the-unarchiver
brew_cask_install webpquicklook
brew_tap caskroom/fonts && brew_cask_install font-fira-code

# npm
if [ `which npm` ]; then
  npm_install browser-sync -g
  npm_install grunt-cli -g
  npm_install gulp -g
  npm_install imageoptim-cli -g
fi

# Ruby Gems
if [ `which gem` ]; then
  gem_install git-up
fi

# Go packages
if [ `which go` ]; then
  go get github.com/b4b4r07/gch
fi


mkdir -p ~/.config/fish
mkdir -p ~/Workspace/bin
mkdir -p ~/Workspace/pkg
mkdir -p ~/Workspace/src

git clone git@github.com:mgaoshima/dotfiles.git ~/Workspace/src/github.com/mgaoshima/dotfiles
cd ~/Workspace/src/github.com/mgaoshima/dotfiles

# link dotfiles
echo "Linking dotfiles..."
ln -sf $(pwd)/config.fish ~/.config/fish/config.fish
ln -sf $(pwd)/vimrc ~/.vimrc
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/gitignore_global ~/.gitignore_global
ln -sf $(pwd)/rsync_excludes ~/.rsync_excludes

# vim-plug - https://github.com/junegunn/vim-plug
if [ -e ~/.vim/autoload/plug.vim ]; then
  echo "vim-plug already installed."
else
  echo "Installing vim-plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +":PlugInstall" +:q
fi

echo ""
echo "======================================================================================"
echo "Download Office Mac 2011..."
echo ">>> wget http://officecdn.microsoft.com/pr/MacOffice2011/ja-jp/MicrosoftOffice2011.dmg"
echo "======================================================================================"
echo ""

# Restart shell
exec $SHELL -l
