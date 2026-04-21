export EDITOR='nvim'
export TERM=xterm-256color

# History & Navigation
setopt HIST_IGNORE_ALL_DUPS
bindkey -v
WORDCHARS=${WORDCHARS//[\/]}

# Environment Variables
export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

# Path Management
typeset -U path PATH
path=(
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.local/bin/test/"
    "$HOME/go/bin"
    "$HOME/.opencode/bin"
    $path
)

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Auto-install/update Zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
[[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]] && source ${ZIM_HOME}/zimfw.zsh init
source ${ZIM_HOME}/init.zsh

# History Search (Arrow Keys & Vim mode)
zmodload -F zsh/terminfo +p:terminfo
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down

# Proxy configuration
proxy_on() {
    export http_proxy="http://127.0.0.1:10808"
    export https_proxy="http://127.0.0.1:10808"
    export HTTP_PROXY="$http_proxy"
    export HTTPS_PROXY="$https_proxy"
}
proxy_off() { unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY; }
proxy_on

# Version Managers & Runtimes
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd --shell zsh)"
[[ -r "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2>&1
export PATH="$PATH:$HOME/.rvm/bin"

# Yazi file manager with cd support
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# Daily Log tool
log() {
    local logdir="$HOME/Notes/logs"
    local today="$(date +%F).md"
    local logfile="$logdir/$today"
    mkdir -p "$logdir"
    [[ ! -f "$logfile" ]] && printf '# %s\n\n' "$today" > "$logfile"
    nvim "$logfile" "+normal G"
}

# ZFM directory switcher
zfm_cd() {
    local target=$(zfm select --dirs 2>/dev/null)
    [[ -n "$target" ]] && cd "$target" 2>/dev/null
    zle reset-prompt
}
if command -v zfm >/dev/null 2>&1 && [[ -o interactive ]]; then
    zle -N zfm_cd
    bindkey '^O' zfm_cd
fi

# System
alias pac='sudo pacman'
alias pQt='pacman -Qtdq | sudo pacman -Rns -'
alias tm='tmux'
alias ll='ls -alF'
alias jl='journalctl'
alias ctl='systemctl'
alias vpn="sudo openvpn ~/Cyber/us.ovpn"

# Editors & Apps
alias vi='nvim'
alias vim='nvim'
alias za='zathura'
alias mc='ncmpcpp'
alias main='nvim main.tex'
alias zrc='nvim ~/.zshrc'

# Rust Development
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

# Utilities
alias rec='wf-recorder'
