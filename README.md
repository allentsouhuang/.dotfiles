# Dev Stack

- Operating System: macOS
- System Package Manager: homebrew
- Terminal: iTerm2
- Shell: bash
- Terminal Multiplexer: tmux
- Version Control: git
- Editor: neovim
- Package Manager: Miniconda
- Notebook: JupyterLab

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
