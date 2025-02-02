#!/usr/bin/env bash

# turn on commonsense bash settings
set -euo pipefail

# turn on tracing
set -x

conda update --yes -n base -c defaults conda
conda env create --yes -f ~/.dotfiles/conda/environment.yaml
conda init bash

# turn off tracing
set +x