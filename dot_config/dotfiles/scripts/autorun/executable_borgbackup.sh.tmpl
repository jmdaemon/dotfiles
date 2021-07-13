#!/bin/sh

log=/var/log/backups/borg

# Helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

USER=jmd
HOST=$(cat /etc/hostname)

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO="/home/$USER/Backups/Borg/Main"
export BORG_PASSCOMMAND="secret-tool lookup user $USER domain $HOST"

if [ -z $( eval ${BORG_PASSCOMMAND} ) ];
then
    info "Error: Passphrase not found in secret-tool"
    exit 1
fi

info "Starting backup"

# Notify user via notify-osd as well
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
    --exclude '/home/*/.cache/*'    \
    --exclude '/var/tmp/*'          \
    --exclude-from ${HOME}'/.local/share/excludes/borg.exclude.list' \
                                    \
    ::'{hostname}-{now}'            \
    /etc                            \
    /home                           \
    /root >> "$log/borg.create.log" 2>&1

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

if [ ${global_exit} -eq 0 ];
then
    info "Backup and Prune finished successfully"
    notify-send -i "drive-optical" "Borg Backup" "Backup and Prune finished successfully."
    date +"%F %T %Z" > "$log/borg.log"
fi

if [ ${global_exit} -eq 1 ];
then
    info "Backup and/or Prune finished with a warning"
    notify-send "Borg Backup" "Backup and/or Prune finished with a warning."
fi

if [ ${global_exit} -gt 1 ];
then
    info "Backup and/or Prune finished with an error"
    notify-send "Borg Backup" "Backup and/or Prune finished with an error."  --urgency=critical
fi

exit ${global_exit}
