#!/usr/bin/env bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# install system-wide stuff
apt update
apt install -y \
	curl \
	vim \
	git \
	silversearcher-ag \
	make \
	g++ \
	docker.io \

# install configs
git clone https://github.com/boo1ean/dotfiles.git

# copy dotfiles
mv dotfiles/.aliases   ./
mv dotfiles/.gitconfig ./
mv dotfiles/.vimrc     ./
mv dotfiles/.zshrc     ./
mv dotfiles/.env       ./
mv dotfiles/.vim       ./
mv dotfiles/.z.sh      ./
rm -rf dotfiles

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install node version manager
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
nvm install stable

chown $SUDO_USER:$SUDO_USER -R ./

vim +BundleInstall +qall
