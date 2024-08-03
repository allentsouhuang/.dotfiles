# Has to come first
# tmux sources /etc/profile which will mess with the path
# https://superuser.com/questions/544989/does-tmux-sort-the-path-variable
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi

# Turn off warnings
export BASH_SILENCE_DEPRECATION_WARNING=1

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Sexy Bash Prompt
# https://gist.github.com/gf3/306785/a35d28b6bdd0f7c54318cce510738438f04dabaa
if [[ $COLORTERM = gnome-* && $TERM = xterm ]]  && infocmp gnome-256color >/dev/null 2>&1; then TERM=gnome-256color; fi
if tput setaf 1 &> /dev/null; then
    tput sgr0
    if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
      MAGENTA=$(tput setaf 9)
      ORANGE=$(tput setaf 172)
      GREEN=$(tput setaf 190)
      PURPLE=$(tput setaf 141)
      WHITE=$(tput setaf 256)
    else
      MAGENTA=$(tput setaf 5)
      ORANGE=$(tput setaf 4)
      GREEN=$(tput setaf 2)
      PURPLE=$(tput setaf 1)
      WHITE=$(tput setaf 7)
    fi
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
else
    MAGENTA="\033[1;31m"
    ORANGE="\033[1;33m"
    GREEN="\033[1;32m"
    PURPLE="\033[1;35m"
    WHITE="\033[1;37m"
    BOLD=""
    RESET="\033[m"
fi
PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]at \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$RESET\] "

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Shortcut to tunnel
alias t='ssh -N -L 8080:localhost:8080 jarvis'
alias tl='ssh -N -L 8889:localhost:8889 lambda'
alias ts='ssh -N -L 8000:localhost:8000 lambda'
alias t1='ssh lambda -t tmux attach -t main'
alias t2='ssh lambda -t tmux attach -t code'

att_m() {
    local cluster_name="$1"
    ssh ${cluster_name} -t tmux attach -t main
}

att_c() {
    local cluster_name "$1"
    ssh ${cluster_name} -t tmux attach -t code
}

# neovim
export PATH=${PATH}:${HOME}/nvim-macos/bin
alias vim='nvim'

# git shortcuts
alias gs='git status'
alias gb='git branch'
alias gd='git diff'
alias gco='git checkout'

# autogenerated nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
