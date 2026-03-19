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

# Proxy
proxy_on() {
    export http_proxy="http://127.0.0.1:10808"
    export https_proxy="http://127.0.0.1:10808"
    export HTTP_PROXY="$http_proxy"
    export HTTPS_PROXY="$https_proxy"
}

proxy_off() {
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
}

proxy_on

# Environment
export EDITOR='nvim'
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"
export TEXINPUTS="$HOME/.config/LaTeX//:"
typeset -U path PATH
path=(
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.local/bin/test/"
    "$HOME/go/bin"
    $path
)

# Node.js version manager
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd --shell zsh)"

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
alias pQt='pacman -Qtdq | sudo pacman -Rns -'
alias tm='tmux'
alias ll='ls -alF'
alias jl='journalctl'
alias ctl='systemctl'

# Editor
alias vi='nvim'
alias vim='nvim'
alias za='zathura'
alias mc='ncmpcpp'


# Rust development
alias vrs='nvim src/main.rs'
alias vtm='nvim Cargo.toml'
alias cdd='cargo add'
alias cun='cargo run'
alias cew='cargo new'
alias can='cargo clean'
alias cst='cargo test'
alias cbd='cargo build'

# Git
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gds='git diff --staged'
gc() { git commit -m "$*"; }
gac() { git add -A && git commit -m "$*"; }

# Config files
alias zrc='nvim ~/.zshrc'

# tools
alias f3='flask-session-cookie-manager3'
alias rec='wf-recorder' # mpv

#LaTeX
alias main='nvim main.tex'

#others
alias esub='exercism submit'

# zfm toggle 
zfm_cd() {
    local target=$(zfm select --dirs 2>/dev/null)
    [[ -n "$target" ]] && cd "$target" 2>/dev/null
    zle reset-prompt
}
if command -v zfm >/dev/null 2>&1 && [[ -o interactive ]]; then
    zle -N zfm_cd
    bindkey '^O' zfm_cd
fi

# Log
log() {
    local logdir="$HOME/Notes/logs"
    local today="$(date +%F).md"
    local logfile="$logdir/$today"
    
    mkdir -p "$logdir"
    [[ ! -f "$logfile" ]] && printf '# %s\n\n' "$today" > "$logfile"
    nvim "$logfile" "+normal G"
}

# Exercism
exercism() {
    local out
    local IFS=$'\n'
    out=($(command exercism "$@"))
    printf '%s\n' "${out[@]}"
    if [[ $1 == "download" && -d "${out[-1]}" ]]; then
        cd "${out[-1]}" || return 1
    fi
}

# opam
[[ -r "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2>&1

# RVM
export PATH="$PATH:$HOME/.rvm/bin"

export TERM=xterm-256color
