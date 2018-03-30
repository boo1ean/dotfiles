#!/usr/bin/env bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cd $HOME

# install system-wide stuff
apt update
apt install -y software-properties-common
add-apt-repository ppa:neovim-ppa/stable

apt update
apt install -y \
	curl \
	neovim \
	zsh \
	git \
	silversearcher-ag \
	make \
	g++ \
	i3 \
	docker.io \

# install configs
git clone https://github.com/boo1ean/dotfiles.git

# setup vim folders and theme
mkdir -p $HOME/.vim/undodir
mkdir $HOME/.vim/colors
mv dotfiles/wombat256.vim $HOME/.vim/colors/

# setup i3
mkdir -p $HOME/.config/i3
mv dotfiles/i3/* $HOME/.config/i3/

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
[ -s "$HOME/.nvm/nvm.sh" ] && \. "$HOME/.nvm/nvm.sh"

chown $SUDO_USER:$SUDO_USER -R ./

vim +BundleInstall +qall
