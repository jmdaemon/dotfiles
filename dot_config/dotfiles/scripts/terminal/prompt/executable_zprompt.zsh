#!/bin/zsh/

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Custom Prompt
POWERLEVEL9K_MODE='nerdfont-complete'
#POWERLEVEL9K_COLOR_SCHEME='gruvbox'
#POWERLEVEL9K_CUSTOM_OS_ICON="echo   $(whoami) "
#POWERLEVEL9K_CUSTOM_OS_ICON_BACKGROUND="black"
#POWERLEVEL9K_CUSTOM_OS_ICON_FOREGROUND="white"
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_os_icon ssh root_indicator anaconda virtualenv dir dir_writable vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon ssh root_indicator anaconda virtualenv dir dir_writable vcs)


POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)

POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K="truncate_beginning"

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2

#PROMPT="%K{black}%F{white} %F{cyan}%f %m %K{red}%F{black}"$'\ue0b0'"%k"
#PROMPT+="%K{red}%F{white} %(4~|%-1~/…/%2~|%4~) %k%F{red}"$'\ue0b0'"%k"
#PROMPT+="%K{yellow}%F{black}  $(git_prompt_info)%k%F{yellow}"$'\ue0b0'"%k"
#PROMPT+="%F{yellow} $ %k%f"

#RPROMPT="%F{yellow}"$'\ue0b2'"%K{yellow}%F{black}  $(git_prompt_info)%k%f"

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "


