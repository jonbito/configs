#!/bin/sh

brew install alacritty ripgrep fish tmux bottom wget node python go rust rust-analyzer luarocks
mkdir -p ~/.config/fish
cp ./.tmux.conf ~/
cp ./.gitconfig ~/
cp ./.config/fish/config.fish ~/.config/fish/
cp ./.config/alacritty/alacritty.yml ~/.config/alacritty/

rm -rf ~/.config/nvim
cp -r ./.config/nvim ~/.config/nvim
