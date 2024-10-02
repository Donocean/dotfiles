# Env
PathAppend() { [ -d "$1" ] && PATH="$PATH:$1"; }
export PATH="/opt/homebrew/bin:$PATH"

if [ -d "/opt/homebrew/opt/binutils/bin" ]; then
  PathAppend "/opt/homebrew/opt/binutils/bin"
fi

# Dynamically add Python bin directories to PATH
if [ -d "$HOME/Library/Python" ]; then
  for dir in $HOME/Library/Python/*; do
    if [ -d "$dir/bin" ]; then
      PathAppend "$dir/bin"
    fi
  done
fi

unset PathAppend

# Editor
export EDITOR="nvim"
export TERMINAL='kitty'

# Fzf
export FZF_COMPLETION_TRIGGER='\\'
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--height 90% --layout reverse --border --color "border:#b877db" --preview="bat --color=always {}"'
