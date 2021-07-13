#!/bin/bash

pip install python-language-server cmake-language-server
npm i -g bash-language-server
GO111MODULE=on go get golang.org/x/tools/gopls@latest
