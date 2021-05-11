#!/bin/bash

gdb -nh -x "$XDG_CONFIG_HOME"/gdb/init
gpg2 --homedir "$XDG_DATA_HOME"/gnupg
nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings
weechat -d "$XDG_CONFIG_HOME"/weechat
mkdir -p "$XDG_DATA_HOME"/wineprefixes
svn --config-dir "$XDG_CONFIG_HOME"/subversion
