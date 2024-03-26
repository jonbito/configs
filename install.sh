#!/bin/sh

brew install alacritty ripgrep tmux bottom wget node python go rust rust-analyzer xwmx/taps/nb
nb set editor nvim
cp ./.tmux.conf ~/
cp ./.gitconfig ~/
cp ./.zshrc ~/
cp ./.p10k.zsh ~/
cp ./.config/alacritty/alacritty.toml ~/.config/alacritty/

rm -rf ~/.config/nvim
cp -r ./.config/nvim ~/.config/nvim

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth 1 -- https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autocomplete
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
