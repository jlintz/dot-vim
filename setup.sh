#!/bin/bash
set +ex

if [[ $(uname) == "Darwin" ]]; then
    READLINK=greadlink
    OS="mac"
elif [[ $(uname) == "Linux" ]]; then
    READLINK=readlink
    OS="linux"
fi

FILE_LOC=$(dirname "$($READLINK -f "${0}")")

if [[ $OS == "mac" ]]; then
    brew install neovim ag fzf nodejs
elif [[ $OS == "linux" ]]; then
    sudo apt install -f -y -q neovim silversearcher-ag fzf nodejs
fi

# setup config directories
mkdir -p ~/.config/nvim
ln -sf ${FILE_LOC}/autoload ~/.config/nvim
ln -sf ${FILE_LOC}/init.vim ~/.config/nvim/
ln -sf ${FILE_LOC}/coc-settings.json ~/.config/nvim/

#Install plugins
nvim --headless -e "+PlugInstall" "+qa"
