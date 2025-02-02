# linux

Exactly what is required to a get a minimal dev environment on a fresh linux box.

``` bash 

##################################################
# Preliminaries
##################################################

# Add the IP Address into ~/.ssh/config on mac

sudo apt update
sudo apt install -y build-essential wget tmux git
cd
git clone https://github.com/allentsouhuang/.dotfiles.git ${HOME}/.dotfiles

##################################################
# Neovim
##################################################

# Need nvm, npm, node for pyright to be installed below
# https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
source ~/.bashrc
nvm install node
nvm install-latest-npm
nvm install --lts

# Cleanup any existing configs
rm -rfv ${HOME}/nvim-linux64/
rm -rf ${HOME}/.local/share/nvim/
rm -rf ${HOME}/.config/nvim

# Go to `https://github.com/neovim/neovim/releases` and choose a release that you want.
# Under assets, right click on the link that looks like nvim-linux64.tar.gz and copy the link.
curl -LO https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
echo 'export PATH=${HOME}/nvim-linux64/bin:${PATH}' >> ~/.bashrc 
echo 'alias vim='nvim >> ~/.bashrc 

mkdir -p .config
cd .config
ln -s ~/.dotfiles/neovim/.config/nvim .
cd
source ~/.bashrc
vim .  # watch it install all the packages!

# Set the macro on p to enter __import__('ipdb').set_trace()

# If you have trouble installing pyright; try removing ~/.local

##################################################
# Miniconda
##################################################

# Set up my tmux flow
# Attach as creating an environment is sometimes slow.
tmux new-session -d -s main
tmux new-session -d -s code
tmux new-session -d -s servers
tmux attach -t main

##################################################
# Jupyter Lab
##################################################

jupyter lab --port 8889
cat ~/.jupyter/jupyter_config.py | grep ServerApp.token
# Settings -> Keyboard Shortcuts -> Search -> "Enter Command Mode"

## On the local machine; aliased to `tl`
ssh -N -L 8889:localhost:8889 lambda

wandb login
```

Ensure that the following runs as expected.

``` python
import torch
print(torch.__version__)
print(torch.version.cuda)
print(torch.backends.cudnn.version())
print(torch.cuda.get_device_name(0))
print(torch.cuda.get_device_properties(0))
print(f"{torch.cuda.is_available()=}")
import torchvision
```

# Conda cheatsheet

```
# Create
conda create --name <> python=3.12

# Create from file
conda env create --yes -f <>

# List
conda env list

# Update single dependency
conda update --yes -n <name> -c <channel> <package>

# Update from list
conda env update --file /home/ubuntu/.dotfiles/conda/environment.yml --prune
```

# macOS

## Homebrew

``` bash

# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ${HOME}/.bash_profile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Check
brew -v

# Maintenance
brew doctor
brew update
brew upgrade
brew cleanup

# Minimal installs
brew install bash tmux git stow
```

Source: https://brew.sh/

## Install configs

``` bash
# Go into .dotfiles directory
git clone https://github.com/allentsouhuang/.dotfiles.git ${HOME}/.dotfiles
cd ${HOME}/.dotfiles

# bash
rm ${HOME}/.bashrc
rm ${HOME}/.bash_profile
stow bash

# tmux
rm ${HOME}/.tmux.conf
stow tmux

# git
rm ${HOME}/.gitconfig
stow git
```

## Neovim

First some macOS-specific prerequisites:

``` bash
# Need developer tools for some plugins to build correctly
xcode-select --install
# Continue in pop-up; this should take around 10 minutes
xcode-select -v

# Need nvm, npm, node for pyright to be installed below
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install-latest-npm
nvm install --lts
nvm -v
npm -v
node -v
```

``` bash
# Cleanup any existing configs
rm -rfv ${HOME}/nvim-macos/
rm -rf ${HOME}/.local/share/nvim/
rm -rf ${HOME}/.config/nvim

cd
# Go to `https://github.com/neovim/neovim/releases` and choose a release that you want.
# Under assets, right click on the link that looks like nvim-macos.tar.gz and copy the link.
curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-macos.tar.gz
tar xzvf nvim-macos.tar.gz
rm nvim-macos.tar.gz
# The following lines are already reflected in .bashrc installed above
# echo 'export PATH=${PATH}:${HOME}/nvim-macos/bin' >> ~/.bashrc 
# echo 'alias vim='nvim >> ~/.bashrc 

# Install
cd ${HOME}/.dotfiles
stow neovim
nvim -v 
nvim  # watch it install all the packages!
```

``` bash
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 20
# restart
```

iTerm2 -> Settings -> Profiles -> Terminal -> Silence Bell
