#!/bin/bash

# add vim ppa
sudo add-apt-repository ppa:jonathonf/vim
sudo apt-get update
sudo apt-get upgrade -y

# vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# tmux themepack
git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack

# git config
git config --global user.email "NestZ671@gmail.com"
git config --global user.name "NestZ"

# restore dotfiles
cd ~
git clone https://github.com/NestZ/dotfiles.git
cd dotfiles
cp .vimrc ../
cp .tmux.conf ../
cp .zshrc ../
cp backup_conf.sh ../

# reload tmux environment
tmux source ~/.tmux.conf

# install nodejs & npm
sudo apt install nodejs npm -y

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
