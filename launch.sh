#!/usr/bin/env bash

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

# setup tmux sessions; side effect: opens a new shell
tmux new-session -d -s main
tmux new-session -d -s code
tmux new-session -d -s servers
tmux attach -t main

# setup conda environment
source ~/.bashrc
conda update --yes -n base -c defaults conda
conda env create --yes -f ~/.dotfiles/conda/environment.yaml

# # setup jupyter
conda activate ai
jupyter lab build
python -m ipykernel install --user --name=ai --display-name="ai"
mkdir -p ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension
cd ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension
ln -s ~/.dotfiles/jupyter/shortcuts.jupyterlab-settings .
cd

# turn off tracing
set +x

echo "Success!"