#!/bin/bash
set +ex

# verify cloned to ~/dot-vim
WORK_DIR="${HOME}/dot-vim"

if [[ $(uname) == "Darwin" ]]; then
    READLINK=greadlink
    OS="mac"
elif [[ $(uname) == "Linux" ]]; then
    READLINK=readlink
    OS="linux"
fi

FILE_LOC=$(dirname "$($READLINK -f "${0}")")

# lazy and expect things to be in proper directory
if [[ $FILE_LOC != "${WORK_DIR}" ]]; then
    echo "ERR: Clone to ${WORK_DIR}"
    exit 1
fi

if [[ $OS == "mac" ]]; then
    brew install neovim ag fzf nodejs
elif [[ $OS == "linux" ]]; then
    sudo apt install -f neovim silversearcher-ag fzf nodejs
fi

# setup config directories
mkdir -p ~/.config/nvim
ln -s ~/dot-vim/autoload ~/.config/nvim
ln -s ~/dot-vim/init.vim ~/.config/nvim/
ln -s ~/dot-vim/coc-settings.json ~/.config/nvim/

#Install plugins
nvim --headless +PlugInstall +qa
