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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/allenhuang/.bash_profile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew doctor
brew update
brew upgrade
brew cleanup
brew install bash tmux git stow
```

## Install configs

``` bash
# Go into .dotfiles directory
cd
git clone <>

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

``` bash
cd
# Go to `https://github.com/neovim/neovim/releases` and choose a release that you want.
# Under assets, right click on the link that looks like nvim-macos.tar.gz and copy the link.
curl -LO https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-macos.tar.gz
tar xzvf nvim-macos.tar.gz
rm nvim-macos.tar.gz
# The following lines are already reflected in .bashrc
# echo 'export PATH=${PATH}:${HOME}/nvim-macos/bin' >> ~/.bashrc 
# echo 'alias vim='nvim >> ~/.bashrc 

# Need developer tools for some plugins to build correctly
xcode-select --install
# Continue in pop-up

# Need nvm, npm, node for pyright to be installed
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install-latest-npm
nvm install --lts

# Cleanup any existing configs
rm -rf ${HOME}/.local/share/nvim/
rm -rf ${HOME}/.config/nvim

cd ${HOME}/.dotfiles
show neovim
nvim
```

# Miniconda

TBD
