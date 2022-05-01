#!/bin/bash

# ?rcupdate=false => Don't modify shell config
curl -s "https://get.sdkman.io?rcupdate=false" | bash

# Update sdkman tool automatically
sdk selfupdate
