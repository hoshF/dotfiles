# Basic zsh settings
setopt HIST_IGNORE_ALL_DUPS    # No duplicate commands in history
bindkey -e                     # Use emacs shortcuts (Ctrl+A, Ctrl+E, etc.)
WORDCHARS=${WORDCHARS//[\/]}   # Better word navigation

# Zim plugin settings
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Zim framework setup
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Auto-install zim if missing
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi

# Update and load zim
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
source ${ZIM_HOME}/init.zsh

# History search with arrow keys
zmodload -F zsh/terminfo +p:terminfo
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

# Environment
export EDITOR='nvim'
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/home/nore/.local/bin"

# Node.js version manager
eval "$(fnm env --shell zsh --use-on-cd --version-file-strategy=recursive --corepack-enabled --resolve-engines)"

# Yazi file manager with cd support
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Aliases
# System
alias pac='sudo pacman'
alias tm='tmux'
alias ll='ls -alF'

# Editor
alias vi='nvim'
alias vim='nvim'

# Rust development
alias vrs='nvim src/main.rs'
alias vtm='nvim Cargo.toml'
alias cdd='cargo add'
alias cun='cargo run'
alias cud='cargo build'
alias cew='cargo new'
alias can='cargo clean'

# Git
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Config files
alias zrc='nvim ~/.zshrc'
alias tx='nvim ~/.config/tmux/tmux.conf'

# zfm toggle 
zfm_cd() {
    local target=$(zfm select --dirs 2>/dev/null)
    [[ -n "$target" ]] && cd "$target" 2>/dev/null
    zle reset-prompt
}
if command -v zfm >/dev/null 2>&1 && [[ -o interactive ]]; then
    zle -N zfm_cd
    bindkey '^P' zfm_cd
fi
