#!/bin/bash

log=/var/log/backups

local_deltalearns="$HOME/Documents/Google Drive/DeltaLearns"
local_main="$HOME/Documents/Google Drive/Main"
remote_deltalearns="google-drive-local_deltalearns:/"
remote_main="google-drive-local_main:/"

backup() {
    local=$1
    remote=$2

    echo "Executing rclone"

    [[ ! -d $log ]] && sudo mkdir $log || :
    /usr/bin/rclone sync "$local" "$remote" \
        --progress \
        --update \
        --verbose \
        --transfers 30 \
        --checkers 8 \
        --contimeout 60s \
        --timeout 300s \
        --retries 3 \
        --low-level-retries 10 \
        --stats 1s >> "$log/gdrive.log" 2>&1

    notify-send -i "drive-optical" "Rclone Google Drive" "Rclone for $remote finished successfully."
}

backup "$remote_deltalearns" "$local_deltalearns"
backup "$local_deltalearns" "$local_main" 
