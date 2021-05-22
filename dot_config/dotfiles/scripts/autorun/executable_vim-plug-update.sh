#!/bin/bash

su jmd
nvim -c PlugUpdate  -c qall
nvim -c PlugUpgrade -c qall
