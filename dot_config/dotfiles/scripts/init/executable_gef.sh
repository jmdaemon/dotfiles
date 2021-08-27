#!/bin/bash

GEF_PATH=$HOME/.config/gdb/init
GDB_INIT_PATH=$HOME/.config/gdb/init/.gdbinit

# Install GEF
git clone https://github.com/hugsy/gef.git $GEF_PATH

# Updates .gdbinit to use GEF
echo "source $GEF_PATH/gef/gef.py" >> $GDB_INIT_PATH

# Optional
pip install capstone ropper unicorn keystone-engine
