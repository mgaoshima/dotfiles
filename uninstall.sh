#!/bin/sh

# dotfiles
cd ~
rm -rf .git* .vim* .z* .oh-my-zsh
rm -rf dotfiles

# Homebrew
curl -L https://gist.githubusercontent.com/mxcl/1173223/raw/a833ba44e7be8428d877e58640720ff43c59dbad/uninstall_homebrew.sh | sh
rm -rf /usr/local/Cellar /usr/local/.git
