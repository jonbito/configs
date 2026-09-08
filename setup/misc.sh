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

## Taskwarrior Configuration
info "Configuring Taskwarrior..."
task rc.confirmation=off config uda.note.type string
task rc.confirmation=off config uda.note.label Note
echo
echo 'Done!' | indent
echo

## Node.js Installation
info "Installing Node.js LTS with fnm..."
fnm install --lts
fnm use lts-latest
fnm default lts-latest
echo
echo 'Done!' | indent
echo

## Codex Installation
info "Installing Codex..."
npm install -g @openai/codex
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

## PI Installation
info "Installing PI..."
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
pi install npm:pi-mcp-adapter
pi install npm:pi-web-access
pi install npm:pi-subagents
pi install npm:@juicesharp/rpiv-ask-user-question
pi install npm:@juicesharp/rpiv-todo
pi install npm:pi-lens
echo
echo 'Done!' | indent
echo
