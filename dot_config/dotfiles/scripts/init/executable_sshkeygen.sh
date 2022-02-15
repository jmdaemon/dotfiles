#!/bin/bash

# Generates and add ssh keys

sshfp="$HOME/.ssh"
keytype="$1"
email="$2"
keyname="$3"

if [[ -z "$keytype" || -z "$email" || -z "$keyname" ]]; then
    echo "Usage: sshkeygen.sh [KEYTYPE] [EMAIL] [KEYNAME]
    Options:
    KEYTYPE         RSA or ED25519
    EMAIL           Your email
    KEYNAME         The name of the keyfile
    "
    exit 1
fi

# Select key type
key=""
if [[ "$keytype" == "RSA" ]]; then
    key="-t rsa -b 2048"
elif [[ "$keytype" == "ED25519" ]]; then
    key="-t ed25519"
fi

# Generate key
ssh-keygen "$key" -C "$email" -f "$SSH_DIR/$keyname"
eval "$(ssh-agent -s)"
ssh-add "$SSH_DIR/$keyname"

# Copy to clipboard
[[ $(command -v xclip) ]] && cat "$SSH_DIR/$keyname.pub" | xclip -sel clip || :
