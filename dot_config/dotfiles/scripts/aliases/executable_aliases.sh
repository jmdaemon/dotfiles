#!/bin/bash/

# LSD - https://github.com/Peltoche/lsd 
alias l='ls -l'
alias ls='lsd'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# Hub - https://hub.github.com/
#alias git=hub
#alias gpr='git pull-request -m "$(git log -1 --pretty=%B)"'
#clonefork() {
#hub clone "$1"
#cd "${1##*/}"
#hub fork
#}

# Shortcuts
alias gtml="cd $HOME/workspace/ml/fastai"
alias mls="source $HOME/.cfg/scripts/ml.zsh"
alias mlss="source $HOME/.cfg/scripts/ml_ssh.zsh"

alias gfonts="cd $XDG_DATA_HOME/fonts"

alias nv='nvim'
alias xclip='xclip -selection c' # X Server copy to clipboard

alias gts="cd $HOME/workspace/School/" 
alias gtw="cd $HOME/workspace"
