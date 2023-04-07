#!/bin/sh

brew install alacritty ripgrep fish tmux lazygit bottom
mkdir -p ~/.config/fish
mkdir -p ~/.config/nvim
if [[ ! -e ~/.config/nvim ]]; then
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
fi
cp ./.tmux.conf ~/
cp ./.gitconfig ~/
cp ./.config/fish/config.fish ~/.config/fish/
cp ./.config/alacritty/alacritty.yml ~/.config/alacritty/
