#!/bin/bash

# conda-clean removes all pkgs that are unused in all conda environments
shopt -s expand_aliases
conda-init
sudo conda clean -a -y
notify-send "Conda" "All unused packages and caches in all conda environments have been removed."
