#!/bin/sh

brew install alacritty ripgrep fish tmux lazygit bottom wget node task python timewarrior
pip3 install pynvim tasklib six packaging
mkdir -p ~/.config/fish
mkdir -p ~/.config/nvim
mkdir -p ~/.task/hooks
cp /opt/homebrew/Cellar/timewarrior/1.5.0/share/doc/timew/ext/on-modify.timewarrior ~/.task/hooks/
chmod +x ~/.task/hooks/on-modify.timewarrior
if [[ ! -e ~/.config/nvim ]]; then
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
fi
cp ./.tmux.conf ~/
cp ./.gitconfig ~/
cp ./.config/fish/config.fish ~/.config/fish/
cp ./.config/alacritty/alacritty.yml ~/.config/alacritty/
