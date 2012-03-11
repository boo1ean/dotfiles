#!/usr/bin/env sh
#
# Author:  Egor Gumenyuk (boo1ean0807 at gmail dot com)
# Updated: Sun Mar 11 16:23:10 UTC 2012
#
# This script will create necessary directories(if not exist), download useful
# vim plugins, colorscheme, and configured vimrc.
#
# List of plugins: pathogen, fugitive, minibufexpl, NERDTree, NERDCommenter,
#                  surround, gundo, tabular.

separator="\n=========================================\n"
installed="was successfully installed $separator"
downloading="Downloading"
vimdir=".vim"

echo "$separator Vim upgrade is started $separator"

# Download latest version from github to home folder
echo "$separator $downloading vimrc...\n"
wget -q https://raw.github.com/boo1ean/vimrc/master/vimrc -O $HOME/.vimrc
echo " Vimrc $installed"

# Create necessary directories
mkdir -p                   \
  "$HOME/$vimdir"          \
  "$HOME/$vimdir/autoload" \
  "$HOME/$vimdir/bundle"   \
  "$HOME/$vimdir/colors"

# Get colorscheme
echo "$separator $downloading colorscheme... \n"
wget -q https://raw.github.com/boo1ean/vimrc/master/wombat256.vim \
  -O "$HOME/$vimdir/colors/wombat256.vim"
echo " Colorscheme $installed"

# Get pathogen
if [ ! -e "$HOME/$vimdir/autoload/pathogen.vim" ]; then
  echo "$separator $downloading pathogen... \n"
  wget -q https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim \
    -O "$HOME/$vimdir/autoload/pathogen.vim"
  echo " Pathogen $installed"
fi

# Start downloading plugins
cd "$HOME/$vimdir/bundle"

# Get fugitive
if [ ! -d ./vim-fugitive ]; then
  echo "$separator $downloading vim-fugitive... \n"
  git clone -q git://github.com/tpope/vim-fugitive.git
  echo " vim-fugitive $installed"
fi

# Get minibufexpl
if [ ! -d ./minibufexpl.vim ]; then
  echo "$separator $downloading minibufexpl... \n"
  git clone -q git://github.com/fholgado/minibufexpl.vim.git
  echo " minibufexpl $installed"
fi

# Get NERDCommenter
if [ ! -d ./nerdcommenter ]; then
  echo "$separator $downloading NERDCommenter... \n"
  git clone -q git://github.com/scrooloose/nerdcommenter.git
  echo " NERDCommenter $installed"
fi

# Get NERDTree
if [ ! -d ./nerdtree ]; then
  echo "$separator $downloading NERDTree... \n"
  git clone -q git://github.com/scrooloose/nerdtree.git
  echo " NERDTree $installed"
fi

# Get gundo
if [ ! -d ./gundo ]; then
  echo "$separator $downloading gundo... \n"
  wget -q http://www.vim.org/scripts/download_script.php?src_id=17406 -O "u.zip"
  unzip -q ./u.zip
  rm u.zip
  echo " gundo $installed"
fi

# Get surround
if [ ! -d ./vim-surround ]; then
  echo "$separator $downloading vim-surround... \n"
  git clone -q git://github.com/tpope/vim-surround.git
  echo " vim-surround $installed"
fi

# Get tabular
if [ ! -d ./tabular ]; then
  echo "$separator $downloading tabular... \n"
  git clone -q git://github.com/godlygeek/tabular.git
  echo " tabular $installed"
fi

# Back to working directory
cd -

echo "$separator Vim upgrade is finished $separator"
