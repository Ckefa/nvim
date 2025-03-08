# Zsh Config
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(zsh-syntax-highlighting zsh-autosuggestions zsh-history-substring-search git)

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"

fzf-history-widget() {
  # Store the current command line content
  local current_command="${BUFFER}"

  # Use fzf to filter through history based on current command
  local selected_command
  selected_command=$(history 1 | grep -E "^ *[0-9]+ *$current_command" | fzf --height 10 --reverse --border --prompt="History> " | sed 's/^[0-9 ]*//')

  # Replace current buffer with selected command if a command was chosen
  if [[ -n $selected_command ]]; then
    BUFFER="$selected_command"
    CURSOR=${#BUFFER}
  fi
  zle redisplay
}

zle -N fzf-history-widget

bindkey '^r' fzf-history-widget
# Enable vi mode
bindkey -v;

# Accept autosuggest-accept
bindkey '^F' forward-word
bindkey '^E' end-of-line
bindkey '^E' autosuggest-accept

# Development Configs
export PATH="$PATH:$(go env GOPATH)/bin"
export EDITOR=nvim
