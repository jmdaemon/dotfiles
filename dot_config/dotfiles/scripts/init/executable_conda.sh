#!/bin/bash

# Helpers
is_installed() {
    pkg="$1"
    return conda list -n base | grep -e ^"$pkg"
}

install() {
    pkg="$1"
    [[ -z $(is_installed $pkg) ]] && mamba install -y -c fastchan $pkg || :
}

clone_ifnot_exists() {
    repo="$1"
    [[ -d "$repo" ]] && git clone https://github.com/fastai/${repo}.git || :
}

# Installation
[[ -z $(is_installed mamba) ]] && conda install -yq mamba || :
conda activate mamba

install pytorch
install fastai
install scikit-learn-intelex
install fastbook

# Cloning
clone_ifnot_exists course20
clone_ifnot_exists fastai
clone_ifnot_exists fastcore
clone_ifnot_exists fastbook
clone_ifnot_exists fastsetup
