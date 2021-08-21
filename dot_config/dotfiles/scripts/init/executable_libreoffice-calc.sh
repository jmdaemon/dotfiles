#!/bin/bash

config="$HOME/.config/libreoffice/4/user/registrymodifications.xcu"

# Use svg icons
sed 's/colibre/colibre_svg' $config 
