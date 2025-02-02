#!/usr/bin/env bash

# turn on commonsense bash settings
set -euo pipefail

# turn on tracing
set -x

# setup conda environment
conda update --yes -n base -c defaults conda
conda env create --yes -f ~/.dotfiles/conda/environment.yaml

# setup jupyter
conda activate ai
jupyter lab build
python -m ipykernel install --user --name=ai --display-name="ai"
mkdir -p ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension
cd ~/.jupyter/lab/user-settings/@jupyterlab/shortcuts-extension
ln -s ~/.dotfiles/jupyter/shortcuts.jupyterlab-settings .
cd

# turn off tracing
set +x