#!/usr/bin/env zsh

command_exists() {
  command -v "$@" &> /dev/null
}

# Eza: https://eza.rocks/
# Display all clickable entries (incl. hidden files) as a grid with icons
command_exists eza && alias ls="eza -a --hyperlink --icons=auto --group-directories-first --color-scale=age"
# Display a detailed list of clickable entries (incl. hidden files) with a Git status
command_exists eza && alias ll="ls --long --no-user --header -g --git"
# Display clickable directory tree
command_exists eza && alias llt="ls --tree --git-ignore"

alias e="nvim"
