#!/usr/bin/env zsh

# Set editor to nvim
export VISUAL=nvim
export EDITOR=$VISUAL

# ----- Bat (better cat) -----
# https://github.com/sharkdp/bat
export BAT_THEME="gruvbox-dark"

# Cancel those terrible ideas Homebrew had of forcing update every 300 s and
# forcing a 3 s curl on every single run.
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1

# GO
export GOPATH="~/go"
