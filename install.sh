#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y

# nvim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# git config
git config --global user.email "NestZ671@gmail.com"
git config --global user.name "NestZ"

# restore dotfiles
cd ~
git clone https://github.com/NestZ/dotfiles.git
cd dotfiles
cd ../config/
mkdir nvim
cd ~/dotfiles/
cp init.vim ../.config/nvim/
cp .tmux.conf ../
cp .zshrc ../
cp backup_conf.sh ../

# tmux themepack
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

# tmux package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# reload tmux environment
tmux source ~/.tmux.conf

# install nodejs & npm
sudo apt install nodejs npm -y

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
