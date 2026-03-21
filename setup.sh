#!/bin/bash
set -e

if [[ $(uname) == "Darwin" ]]; then
    OS="mac"
elif [[ $(uname) == "Linux" ]]; then
    OS="linux"
else
    echo "Unsupported OS: $(uname)"
    exit 1
fi

# resolve script directory
if [[ $OS == "mac" ]]; then
    # install coreutils for greadlink if missing
    if ! command -v greadlink &>/dev/null; then
        brew install coreutils
    fi
    FILE_LOC=$(dirname "$(greadlink -f "${0}")")
else
    FILE_LOC=$(dirname "$(readlink -f "${0}")")
fi

# install dependencies
if [[ $OS == "mac" ]]; then
    brew install neovim fzf ripgrep node
elif [[ $OS == "linux" ]]; then
    sudo apt update -q
    sudo apt install -f -y -q neovim fzf ripgrep nodejs npm
fi

# setup config directory and symlinks
mkdir -p ~/.config/nvim
ln -sf "${FILE_LOC}/autoload" ~/.config/nvim/
ln -sf "${FILE_LOC}/init.vim" ~/.config/nvim/
ln -sf "${FILE_LOC}/coc-settings.json" ~/.config/nvim/

# install plugins
nvim --headless "+PlugInstall --sync" "+qa"
