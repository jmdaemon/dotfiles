#!/bin/bash

# Update to latest sys config
shopt -s expand_aliases # Enable aliases
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
BR=$(cfg branch --show-current)
cfg fetch upstream $BR # Get newest changes
