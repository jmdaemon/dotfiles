#!/bin/sh

sshfp="$HOME/.ssh"

ls "$sshfp" | grep -v ".pub" | grep "id" | xargs chmod 600  # Private keys
ls "$sshfp" | grep ".pub" | grep "id" | xargs chmod 644     # Public keys
