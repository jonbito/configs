#!/bin/bash

set -euo pipefail

cd "$(dirname $0)"

red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
light_red=$(tput setaf 9)
bold=$(tput bold)
reset=$(tput sgr0)

title() {
  echo "${bold}==> $1${reset}"
  echo
}

warning() {
  tput setaf 1
  echo "/!\\ $1 /!\\"
  tput sgr0
}

command_exists() {
  command -v "$@" &>/dev/null
}

echo -e "${yellow}!!! ${red}WARNING${yellow} !!!"
echo -e "${light_red}This script will delete all your configuration files!"
echo -e "${light_red}Use it at your own risk."

if [ $# -ne 1 ] || [ "$1" != "-y" ]; then
  echo -e "${yellow}Press Enter key to continue...${reset}\n"
  read key
fi

# Backup existing zsh file
if [[ -e "$HOME/.zshrc" ]]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

title "🫖 Setting up Homebrew..."
./setup/brew.sh
echo

title "Setting up Oh My Zsh..."
./setup/oh-my-zsh.sh
echo

# Install dotfiles symlinks
title "🍤 Setting up symlinks..."
./setup/symlinks.sh
echo

# Install rust
title "🚀 Setting up extra tools..."
./setup/misc.sh
echo

echo "🦏 ${green}All done! Open a new terminal for the changes to take effect.${reset}"
