#!/bin/bash

# Adds gpg keys securely

KEYDIR="/etc/apt/trusted.gpg.d"
keyurl="$1"
pkg="$2"

if [[ -z "$keyurl" || -z "$pkg" ]]; then
    echo "Usage: gpgkeys.sh [keyurl] [pkg]"
    exit 1
fi

# Add GPG Key
if [[ ! -e "$KEYDIR/$pkg.gpg") ]]; then
    wget -O - "$keyurl" > "$pkg.key"
    gpg --no-default-keyring --keyring "./${pkg}_keyring.gpg" --import "$pkg.key"
    gpg --no-default-keyring --keyring "./${pkg}_keyring.gpg" --export > "./$pkg.gpg"
    sudo mv "./$pkg.gpg" "$KEYDIR"
    rm "$pkg.key ${pkg}_keyring.gpg" "${pkg}_keyring.gpg\~"
fi

