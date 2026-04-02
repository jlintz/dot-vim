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
    if ! command -v greadlink &>/dev/null; then
        brew install coreutils
    fi
    FILE_LOC=$(dirname "$(greadlink -f "${0}")")
else
    FILE_LOC=$(dirname "$(readlink -f "${0}")")
fi

# install dependencies
echo "Installing dependencies..."
if [[ $OS == "mac" ]]; then
    brew install neovim fzf fd ripgrep tree-sitter-cli 2>/dev/null || true
elif [[ $OS == "linux" ]]; then
    sudo apt update -q
    sudo apt install -f -y -q neovim fzf fd-find ripgrep tree-sitter-cli
fi

# setup config directory and symlinks
echo "Setting up config symlinks..."
mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.vim  # remove old vimscript config if present
ln -sf "${FILE_LOC}/init.lua" ~/.config/nvim/
ln -sf "${FILE_LOC}/nvim-pack-lock.json" ~/.config/nvim/ 2>/dev/null || true

# install plugins
echo "Installing plugins..."
nvim --headless +"lua vim.pack.update(nil, { force = true })" +qa

echo "Done!"
