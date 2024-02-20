#!/bin/bash

# Create whitelists for earlyoom
EXIT_FAILURE=1

# Join array into string
function join_by {
  local d=${1-} f=${2-}
  if shift 2; then
    printf %s "$f" "${@/#/$d}"
  fi
}

EARLYOOM_WHITELIST="$XDG_DATA_HOME/earlyoom/whitelist.sh"

# Ensure the whitelist exists
if [[ -f "$EARLYOOM_WHITELIST" ]]; then
    source "$EARLYOOM_WHITELIST"
else
    echo "No earlyoom whitelist detected. To make one please run:"
    echo "\ttouch $EARLYOOM_WHITELIST"
    exit EXIT_FAILURE
fi

avoid=$(join_by '|' "${apps[@]}")

EARLYOOM_ARGS="-m 5 -s 90 -r 3600 -n --avoid '(^|/)('${avoid}')$'"

echo "EARLYOOM_ARGS=$EARLYOOM_ARGS"
