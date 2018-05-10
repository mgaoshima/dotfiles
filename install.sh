#!/bin/bash


# Xcode Command Line Tools
if [ -z `which gcc` ]; then
  xcode-select --install
fi

# Homebrew
if [ -z `which brew` ]; then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap caskroom/cask caskroom/fonts
fi

brew install \
  ack \
  cmake \
  fish \
  fzf \
  ghq \
  git \
  go \
  htop \
  libpng \
  lv \
  nkf \
  node \
  translate-shell \
  tree \
  vim --override-system-vi \
  wget \
  youtube-dl

brew cask install \
  appcleaner \
  imageoptim \
  integrity \
  kaleidoscope \
  keka \
  macwinzipper \
  name-mangler \
  qlcolorcode \
  qlimagesize \
  qlmarkdown \
  qlstephen \
  quicklook-csv \
  quicklook-json \
  the-unarchiver \
  webpquicklook \
  font-fira-code

# brew cask install \
#   adobe-creative-cloud \
#   microsoft-office


# npm
npm install -g \
  browser-sync \
  grunt-cli \
  gulp \
  imageoptim-cli

# Go packages
go get \
  github.com/b4b4r07/gch


mkdir -p ~/.config/fish
mkdir -p ~/Workspace/bin
mkdir -p ~/Workspace/pkg
mkdir -p ~/Workspace/src

# dotfiles repo
DOTFILES_DIR=~/Workspace/src/github.com/mgaoshima/dotfiles
DOTFILES_REPO=git@github.com:mgaoshima/dotfiles.git
if [ -e $DOTFILES_DIR ]; then
  echo "mgaoshima/dotfiles already cloned."
else
  echo "Cloning mgaoshima/dotfiles..."
  git clone $DOTFILES_REPO $DOTFILES_DIR
fi
cd $DOTFILES_DIR

# link dotfiles
echo "Linking dotfiles..."
ln -sf $(pwd)/config.fish ~/.config/fish/config.fish
ln -sf $(pwd)/vimrc ~/.vimrc
ln -sf $(pwd)/gitconfig ~/.gitconfig
ln -sf $(pwd)/gitignore_global ~/.gitignore_global
ln -sf $(pwd)/gitattributes_global ~/.gitattributes_global
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

# Restart shell
exec $SHELL -l
