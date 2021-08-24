#!/bin/bash

# Based on: https://github.com/gillescastel/inkscape-shortcut-manager/blob/master/examples/config.py

# Search for available windows with window class name "popup-bottom-center"
wid=$(xdotool search --class "popup-bottom-center")
# Resize alacritty window
xdotool windowsize $wid 1600 400
# Move "popup" terminal window to bottom left
xdotool windowmove $wid 400 1400
