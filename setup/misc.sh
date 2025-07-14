#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")/.."

DOTFILES_DIR="$(pwd)"

BLUE=$(tput setaf 4)
BOLD=$(tput bold)
RESET=$(tput sgr0)

indent() {
  sed 's/^/  /'
}

info() {
  echo
  echo "[ ${BLUE}..${RESET} ] $1" | indent
}

warning() {
  tput setaf 1
  echo "/!\\ $1 /!\\"
  tput sgr0
}

command_exists() {
  command -v "$@" &>/dev/null
}

## Node.js Installation
info "Installing Node.js LTS with fnm..."
fnm install --lts
fnm use lts-latest
fnm default lts-latest
echo
echo 'Done!' | indent
echo

## Claude Code Installation
info "Installing Claude Code..."
npm install -g @anthropic-ai/claude-code
echo
echo 'Done!' | indent
echo

## Rust Installation
info "Installing rust..."
rustup default stable
rustup update
rustup component add rust-analyzer
echo
echo 'Done!' | indent
echo
