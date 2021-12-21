#!/bin/sh

USER="$1"

sudo groupadd android-sdk
sudo gpasswd -a "$USER" android-sdk
sudo setfacl -R -m g:android-sdk:rwx /opt/android-sdk
sudo setfacl -d -m g:android-sdk:rwX /opt/android-sdk
newgrp android-sdk
