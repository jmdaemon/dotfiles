#!/bin/bash

# Helpers
is_installed() {
    pkg="$1"
    return conda list -n base | grep -e ^"$pkg"
}

# Installation
[[ -z $(is_installed mamba) ]] && conda install -yq mamba || :
conda activate mamba
install() {
    pkg="$1"
    [[ -z $(is_installed $pkg) ]] && mamba install -y -c fastchan $pkg || :
}

install pytorch
install fastai
install scikit-learn-intelex
install fastbook

# Cloning
[[ -d "~/Workspace/fastai/fastbook" ]] && git clone https://github.com/fastai/fastbook.git || :
