#!/bin/bash

i3-agenda -cd ~/.config/polybar/i3-agenda -c ~/.config/polybar/i3-agenda/google_credentials.json -ttl 60 -i "$cat cal.json | jq '.school')" -d --no-event-text ""
