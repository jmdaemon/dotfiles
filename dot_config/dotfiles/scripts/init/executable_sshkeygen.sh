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
    #key="-t rsa -b 2048"
    key="-t rsa -b 4096"
elif [[ "$keytype" == "ED25519" ]]; then
    key="-t ed25519"
else
    echo "You must provide a keytype."
    echo "Keytypes available are: RSA, ED25519"
    exit 2
fi

keyfile="$sshfp/$keyname"

# Generate key
ssh-keygen $key -C "$email" -f $keyfile

# Set correct permissions on keyfile
chmod 600 $keyfile

if [[ -f $keyfile ]]; then
    # Add the ssh key
    eval "$(ssh-agent -s)"
    ssh-add "$keyfile"

    # Copy the public key to the clipboard
    [[ $(command -v xclip) ]] && cat "$sshfp/$keyname.pub" | xclip -sel clip || :
fi
