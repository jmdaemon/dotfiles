#!/bin/bash/

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
XDG_CONFIG_HOME=/home/jmd/.config
export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
[[ -e "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
