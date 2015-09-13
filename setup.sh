#!/usr/bin/env bash

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
	ncdu \
	vifm \
	silversearcher-ag \
	redis-server \
	nginx-full \
	make \
	g++ \
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
mv dotfiles/.env       ./
mv dotfiles/.vim       ./

rm -rf dotfiles

# Install node
wget https://nodejs.org/dist/v4.0.0/node-v4.0.0-linux-x64.tar.gz
tar -xvf node-v4.0.0-linux-x64.tar.gz
rm node-v4.0.0-linux-x64.tar.gz

chown $SUDO_USER:$SUDO_USER -R ./

vim +BundleInstall +qall
