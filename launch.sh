#!/usr/bin/env bash

# tmux
ln -sf .dotfiles/tmux/.tmux.conf .

# git
ln -sf .dotfiles/git/.gitconfig .

# bash aliases
ln -sf .dotfiles/bash/.bash_aliases .

# This bash profile just ensures that the bashrc is run last
ln -sf .dotfiles/bash_linux/.bash_profile .

# pdbrc
ln -sf .dotfiles/pdbrc/.pdbrc.py .

# install miniconda
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

# setup environment
~/miniconda3/bin/conda init bash
source ~/.bashrc
conda update --yes -n base -c defaults conda
conda env create --yes -f ${HOME}/.dotfiles/conda/environment.yaml
conda activate ai
jupyter lab build

# setup tmux sessions
tmux new-session -d -s main
tmux new-session -d -s code
tmux new-session -d -s servers
tmux attach -t main