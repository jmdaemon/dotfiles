# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export DOTFILES="$HOME/.config/dotfiles"

export ZDOTDIR=$DOTFILES/zsh
# https://github.com/ohmyzsh/ohmyzsh/issues/7332#issuecomment-593308026
skip_global_compinit=1
ZSH_CACHE_DIR=$HOME/.cache/zsh
ZSH_COMPDUMP="${ZSH_CACHE_DIR}/.zcompdump-${HOST/.*/}-${ZSH_VERSION}"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $DOTFILES/scripts/terminal/base16.sh
source $DOTFILES/scripts/terminal/prompt/zprompt.zsh
#source $DOTFILES/scripts/tprompt/zsh/zprompt.zsh

HISTFILE=$HOME/.history/zsh/arch-laptop/.zsh_history
HISTSIZE=10000
SAVEHIST=10000


fpath=( ~/config/.zsh/completion $fpath ~/.cfg/scripts/completion )
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
#autoload -Uz compinit && compinit -i
autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.  COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git gradle-completion )
#plugins+=(gradle-completion)

# Added in quick hack
source $ZSH/oh-my-zsh.sh
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
#

#source $HOME/.cfg/scripts/aliases/aliases.zsh
#source $HOME/.cfg/scripts/tstart/hidpi.sh
#source $HOME/.cfg/scripts/tstart/conda-init.sh
#source $HOME/.profile
#source $HOME/.cfg/scripts/tstart/sdkman.sh

source $DOTFILES/scripts/aliases/aliases.zsh
source $DOTFILES/scripts/terminal/hidpi.sh
source $DOTFILES/scripts/terminal/conda-init.sh
source $DOTFILES/scripts/terminal/sdkman.sh
source $HOME/.profile

# Persistent Tmux Sessions
#if [ $(tty) == /dev/tty1 ]; then
#  /usr/bin/tmux new -s 0
#  /usr/bin/tmux attach -t 0
#fi 
