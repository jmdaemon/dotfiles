#!/bin/bash

# Set SBCLRC file to $XDG_CONFIG_HOME/sbcl/sbclrc
if [[ ! -e /etc/sbclrc ]]; then
    echo "(require :asdf)
    (setf sb-ext:*userinit-pathname-function*
          (lambda () (uiop:xdg-config-home #P"sbcl/sbclrc")))
          "
          | sudo tee /etc/sbclrc
fi
