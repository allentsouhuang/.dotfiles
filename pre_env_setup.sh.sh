#!/usr/bin/env bash

# turn on commonsense bash settings
set -euo pipefail

# turn on tracing
set -x

# tmux
ln -sf .dotfiles/tmux/.tmux.conf .

# git
ln -sf .dotfiles/git/.gitconfig .

# bash aliases
ln -sf .dotfiles/bash_common/.bash_aliases .

# This bash profile just ensures that the bashrc is run last
ln -sf .dotfiles/bash_linux/.bash_profile .

# pdbrc
ln -sf .dotfiles/pdbrc/.pdbrc.py .

# install miniconda
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

~/miniconda3/bin/conda init bash

# turn off tracing
set +x