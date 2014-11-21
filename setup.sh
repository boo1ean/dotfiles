#!/usr/bin/env bash

# setup dotdeb repos
#
# wget http://www.dotdeb.org/dotdeb.gpg
# apt-key add dotdeb.gpg
# rm dotdeb.gpg
# 
# echo "deb http://packages.dotdeb.org wheezy all" | tee -a /etc/apt/sources.list.d/dotdeb.list
# echo "deb-src http://packages.dotdeb.org wheezy all" | tee -a /etc/apt/sources.list.d/dotdeb.list

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install system-wide stuff
apt-get update
apt-get install -y \
	tmux \
	vim \
	git \
	nginx-full \
	postgresql-9.3 \
	postgresql-server-dev-9.3 \
	postgresql-client-9.3

# install configs
git clone https://github.com/boo1ean/dotfiles.git
mv dotfiles/.aliases   ./
mv dotfiles/.bashrc    ./
mv dotfiles/.gitconfig ./
mv dotfiles/.tmux.conf ./
mv dotfiles/.vimrc     ./
mv dotfiles/.zshrc     ./
mv dotfiles/.vim       ./

rm -rf dotfiles

vim +BundleInstall +qall

chown $SUDO_USER:$SUDO_USER -R ./
