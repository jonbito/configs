# ----- Homebrew -----
# https://brew.sh
eval "$(/opt/homebrew/bin/brew shellenv)"

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

alias e="nvim"

export PATH="~/go/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Starship prompt (needs to be at the end)
if [ $(command -v "starship") ]; then
  source $HOME/.config/zsh/prompt.zsh
fi
