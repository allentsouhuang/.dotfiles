#!/usr/bin/env bash

# tmux
ln -s .dotfiles/tmux/.tmux.conf .

# git
ln -s .dotfiles/git/.gitconfig .

# bash aliases
ln -s .dotfiles/bash/.bash_aliases .

# This bash profile just ensures that the bashrc is run last
ln -s .dotfiles/bash_linux/.bash_profile .

# pdbrc
ln -s .dotfiles/pdbrc/.pdbrc.py .

# install miniconda
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

# setup environment
~/miniconda3/bin/conda init bash
source ~/.bashrc
conda update --yes -n base -c defaults conda
conda env create --yes -f /home/ubuntu/.dotfiles/conda/environment.yml
conda activate ai2
jupyter lab build