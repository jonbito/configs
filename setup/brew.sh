#!/bin/bash

set -euo pipefail

bold=$(tput bold)
reset=$(tput sgr0)

title() {
  echo "${bold}==> $1${reset}"
  echo
}

indent() {
  sed 's/^/  /'
}

# Check for Homebrew and install it if required
if ! command -v brew &>/dev/null; then
  title "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$($(brew --prefix)/bin/brew shellenv)"
fi

# Make sure we’re working with the latest version of Homebrew and its formulae
brew update

# Upgrade outdated already-installed formulae
brew upgrade

# Install brew software
if [[ "$(uname -s)" == "Darwin" ]]; then
  brew bundle --file="$(pwd)/setup/macos.Brewfile" | indent
else
  brew bundle --file="$(pwd)/setup/linux.Brewfile" | indent
fi

brew cleanup
