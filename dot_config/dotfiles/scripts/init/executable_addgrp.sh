#!/bin/bash

grpexists() {
    if [ $(getent group $1) ]; then
        return 0
    else
        return 1
    fi
}

show_usage() {
    echo "      addgrp.sh [group name] [user name] [/opt/program directory]"
}

group="$1"
user="$2"
optfp="$3"

if [[ -z "$group" || -z "$user" || -z "$optfp" ]]; then
    show_usage
else
    if [[ grpexists "$group" ]]; then
        echo "$group already exists."
        return 0
    fi
    sudo groupadd "$group"
    sudo gpasswd -a "$user" "$group"
    sudo setfacl -R -m g:"$group":rwx /opt/"$optfp"
    sudo setfacl -d -m g:"$group":rwX /opt/"$optfp"
    newgrp "$group"
fi
