#!/usr/bin/env bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

cd $HOME
VIM_HOME=$HOME/.config/nvim
I3_HOME=$HOME/.config/i3

mkdir $HOME/screenshots
mkdir -p $VIM_HOME/undodir
mkdir $VIM_HOME/colors
mkdir -p $I3_HOME

# install system-wide stuff
apt update
apt install -y software-properties-common
add-apt-repository ppa:neovim-ppa/stable

apt update
apt install -y \
	python3.5 \
	neovim \
	zsh \
	git \
	silversearcher-ag \
	htop \
	make \
	g++ \
	scrot \
	tree \
	i3 \
	xclip \
	docker.io \

# install pip
curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
python3.5 get-pip.py
python2.7 get-pip.py
rm get-pip.py

# install configs
git clone https://github.com/boo1ean/dotfiles.git
# setup i3
mv dotfiles/.config/i3/* $I3_HOME/

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install node version manager
curl -fsSL https://github.com/Schniz/fnm/raw/master/.ci/install.sh | bash
export PATH=/home/kmenux/.fnm:$PATH
eval "`fnm env --multi`"
fnm install 12

# copy dotfiles
mv dotfiles/.aliases   ./
mv dotfiles/.gitconfig ./
mv dotfiles/.zshrc     ./
mv dotfiles/.env       ./
mv dotfiles/.z.sh      ./

# setup vim
mv dotfiles/.config/nvim/colors/wombat256.vim $VIM_HOME/colors/
mv dotfiles/.config/nvim/init.vim $VIM_HOME/

rm -rf dotfiles

git clone https://github.com/VundleVim/Vundle.vim.git $VIM_HOME/bundle/Vundle.vim
nvim +PluginInstall +qall && chown $SUDO_USER:$SUDO_USER -R ./ && echo 'IM FINE'
