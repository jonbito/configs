# ----- Homebrew -----
# https://brew.sh
if [[ $(uname -s) == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ----- Direnv  -----
# https://github.com/direnv/direnv
eval "$(direnv hook zsh)"

# ----- Fnm (node manager) -----
# https://github.com/Schniz/fnm
eval "$(fnm env --use-on-cd)"

# ----- Antidote -----
# https://github.com/mattmc3/antidote
source $(brew --prefix)/share/antidote/antidote.zsh
antidote load


source $HOME/.config/zsh/aliases.zsh
source $HOME/.config/zsh/path.zsh
source $HOME/.config/zsh/env.zsh
source $HOME/.config/zsh/keybindings.zsh


# Allow local (private) customizations (not checked in to version control)
[ -f ~/.zsh.local ] && source ~/.zsh.local

# Enable fzf: https://github.com/junegunn/fzf
if [ $(command -v "fzf") ]; then
  source $HOME/.config/zsh/fzf.zsh
fi

# Enable ngrok autocompletions
if [ $(command -v "ngrok") ]; then
  eval "$(ngrok completion)"
fi

# Starship prompt (needs to be at the end)
if [ $(command -v "starship") ]; then
  source $HOME/.config/zsh/prompt.zsh
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
