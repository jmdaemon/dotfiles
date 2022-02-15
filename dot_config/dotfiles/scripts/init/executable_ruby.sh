#!/bin/bash

# Sets up rbenv, and ruby-build

rbbuildfp="$HOME/.config/rbenv/plugins/ruby-build"
shimsfp="$HOME/.rbenv/shims"
gemsfp="$HOME/.rbenv/bin"

log() {
  echo "== $* ==" 1>&2
  echo 1>&2
}

install() {
    pkg="$1"
    if [[ -e "$(command -v "$pkg")" ]]; then
        sudo "$apt" install -y "$pkg"
        log Installing "$pkg"
    fi
}

is_rbenv_init() {
    shellrc="$1"
    log "Initializing rbenv for shell $shellrc"
    result=$(grep -P 'eval "$(rbenv init -)' < "$shellrc")
    return "$result"
} 

# Set apt-fast if installed or default to apt
apt=""
[[ -e $(command -v apt-fast) ]] && apt="apt-fast" || apt="apt"
log Using $apt

install rbenv

if [[ ! -d "$rbbuildfp" ]]; then
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
    log Installing ruby-build
fi

# Sets up Ruby Shims & Gems paths if not found in PATH
shims_in_path=$(echo "$PATH" | grep "$shimsfp")
gems_in_path=$(echo "$PATH" | grep "$gemsfp")
pathappend=""
[[ -n $shims_in_path && -z $RUBY ]] && pathappend="$shimsfp" || :
[[ -n $gems_in_path && -z $GEM_BIN ]] && pathappend+=":$gemsfp" || :
[[ -n "$pathappend" ]] && export PATH="$pathappend:$PATH" || :

# Sets up rbenv in shell rc
rbenv_initialized=$(is_rbenv_init "$HOME/.profile")
if [[ -z "$rbenv_initialized" ]]; then
    if echo "$SHELL" | grep -q zsh; then
        [[ -n $rbenv_initialized && -z "$(is_rbenv_init $HOME/.zshrc)" ]] && echo 'eval "$(rbenv init -)"' >>"$HOME"/.zshrc || :
    else
        echo 'eval "$(rbenv init -)"' >>"$HOME"/.bashrc || :
    fi
fi

# Check to see if installation was successful
log Checking rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

# Install your ruby versions with
# rbenv install $RUBY_VERSION

# Install your gems with
# gem install $GEM
