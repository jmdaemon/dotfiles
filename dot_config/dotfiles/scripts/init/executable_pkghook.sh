#!/bin/bash

DEST="/etc/pacman.d/hooks"
HOOKS_DIR="$HOME/.config/dotfiles/hooks/pacman"
REHASH_DIR=/var/cache/zsh

# https://wiki.archlinux.org/title/Zsh#On-demand_rehash
setup_zsh_auto_rehash() {
    if [[ ! -d $DEST ]]; then sudo mkdir $DEST; else :; fi
    if [[ ! -z $DEST/zsh.hook ]]; then sudo cp $HOOKS_DIR/zsh.hook $DEST; else :; fi
    if [[ ! -d $REHASH_DIR ]]; then sudo mkdir $REHASH_DIR; else :; fi

}

show_usage() {
    echo "Usage: pkghook.sh [hook]"
    echo "      -r, --rehash,       Rehash to find new executables in \$PATH"
    echo "                          after new package installation"
    echo ""
}

opt="$1"
if [[ -z "$opt" ]]; then
  show_usage
elif [[ "$opt" == "-r" || "$opt" == "--rehash" ]]; then
    setup_zsh_auto_rehash
fi
