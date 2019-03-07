# Setup
 - Clone repo
 - `ln -s ~/dot-vim ~/.vim`
 - `ln -s ~/dot-vim/.vimrc ~/.vimrc`
 - `cd ~/.vim`
 - `git submodule update --init --recursive`
 - `brew install ag`
 - `pip install jedi`
 - `pip install flake8`

# Updating submodiles
 - `git submodule update --remote`

# Adding New Plugin
`git submodule add $REPO bundle/$NAME`
