#!/bin/bash

USER=jmd
HOME=/home/$USER
HOST=$(cat /etc/hostname)
log=$HOME/.history/log/backups/borg
filepass="$HOME/.local/share/gpg"/borgpass.gpg

# Helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
notify_user() {
    msg=$1
    status=$2
    if [[ "$status" == "Success" ]]; then
        notify-send -i "drive-optical" "Borg Backup" "$msg"
    elif [[ "$status" == "Warning" ]]; then
        notify-send "Borg Backup" "$msg"
    elif [[ "$status" == "Critical" ]]; then
        notify-send "Borg Backup" "$msg" --urgency=critical
    fi
    date +"[%F %T %Z] $msg" >> "$log/borg.log"
}

trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO="$HOME/Backups/Borg/Main"
export BORG_PASSCOMMAND="gpg --quiet -d --batch --passphrase borgpass $filepass"

# Log all output
[[ ! -d $log ]] && mkdir -p $log || :

cmd_output=$(eval "${BORG_PASSCOMMAND}")
if [ -z "$cmd_output" ]; then
    msg="Error: Borg password command failed"
    info "$msg"

    { date +"[%F %T %Z] "; printf "Environment\n%s" "$(env)"; } >> "$log/borg.log"
    { date +"[%F %T %Z] "; printf "\$ %s\n%s" "$BORG_PASSCOMMAND" "$cmd_output"; } >> "$log/borg.log"
    { date +"[%F %T %Z] "; printf "%s" "$msg"; } >> "$log/borg.log"
    exit 1
fi

info "Starting backup"
notify-send "Borg Backup" "Starting backup for $USER"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:
borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude-caches                \
    --exclude '/home/lost+found'    \
    --exclude '/home/*/.cache/*'    \
    --exclude '/var/tmp/*'          \
    --exclude-from $HOME'/.local/share/excludes/borg.exclude.list' \
                                    \
    ::'{hostname}-{now}'            \
    /home >> "$log/borg.create.log" 2>&1

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6 >> "$log/borg.prune.log" 2>&1

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
    notify_user "Backup and Prune finished successfully." "Success"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with a warning"
    notify_user "Backup and/or Prune finished with a warning." "Warning"
elif [ ${global_exit} -gt 1 ]; then
    info "Backup and/or Prune finished with an error"
    notify_user "Backup and/or Prune finished with an error." "Critical"
fi

exit ${global_exit}
