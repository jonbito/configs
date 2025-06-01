# Prepend PATH by skipping duplicates
declare -U PATH

prepend() {
  [ -d "$1" ] && PATH="$1:$PATH"
}

prepend "$HOME/.local/bin"
prepend "$HOME/go/bin"
prepend "$(brew --prefix)/opt/openjdk/bin"
prepend "$HOME/.cargo/bin"
prepend "$HOME/.local/share/fnm"
prepend "$HOME/.bin"

# Prevent it from being used accidentally elsewhere in the script or by other scripts
unset prepend

export PATH
