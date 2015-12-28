#!/bin/zsh


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
brew_install brew-cask
brew_install cmake
brew_install git
brew_install git-lfs
brew_install go
brew_install hub
brew_install libpng
brew_install lv
brew_install nkf
brew_install node
brew_install peco
brew_install tree
brew_install vim --override-system-vi --with-lua
brew_install wget
brew_install youtube-dl
brew_install zsh
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
brew_cask_install qlmarkdown
brew_cask_install sourcetree
brew_cask_install the-unarchiver
brew_cask_install versions

# npm
if [ `which npm` ]; then
  npm_install browser-sync -g
  npm_install imageoptim-cli -g
  npm_install grunt-cli -g
fi

# Ruby Gems
if [ `which gem` ]; then
  gem_install git-up
fi

# Go packages
if [ `which go` ]; then
  go get github.com/b4b4r07/gch
fi


# Prezto - https://github.com/sorin-ionescu/prezto
if [ -e ~/.zprezto ]; then
  echo "Prezto already installed."
else
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

mkdir -p ~/Workspace/bin
mkdir -p ~/Workspace/pkg
mkdir -p ~/Workspace/src

ghq get -p git@github.com:mgaoshima/dotfiles.git
cd $(GOPATH)/github.com/mgaoshima/dotfiles

# link dotfiles
echo "Linking dotfiles..."
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.zpreztorc ~/.zpreztorc
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.gitignore_global ~/.gitignore_global



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
