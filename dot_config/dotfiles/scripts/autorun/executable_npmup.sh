#!/bin/bash

# Export path for use in crontab scripts
export PATH=/usr/bin/

# Ensure Node Version Manager is available
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

# Update NPM
nvm install --latest-npm

# Update NodeJS
nvm install node --reinstall-packages-from=node # Reinstall previous global npm packages
notify-send "Node Version Manager Upgrade" "Nvm has been updated."

npm update -g
notify-send "Node Package Manager Upgrade" "Npm has been updated."

yarn global upgrade
notify-send "Yarn Package Manager Upgrade" "Yarn has been updated."
