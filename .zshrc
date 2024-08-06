# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Set brew path
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab

# Add in oh-my-zsh plugins
zinit snippet OMZP::azure
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::command-not-found
zinit snippet OMZP::copyfile
zinit snippet OMZP::dircycle
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::extract
zinit snippet OMZP::git
zinit snippet OMZP::pip
zinit snippet OMZP::sudo
zinit snippet OMZP::web-search

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias la='ls -la'
alias c='clear'

# Python3 local binaries
export PATH=$PATH:~/.local/bin

# Shell integrations
source <(fzf --zsh)
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/theme.omp.yaml)"
