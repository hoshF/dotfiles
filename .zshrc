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
export LIBVA_DRIVER_NAME=nvidia
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1
export QT_OPENGL=egl
export EGL_PLATFORM=wayland

export EDITOR='nvim'
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/home/nore/.local/bin"

# proxy toggle
proxy_on() {
    export http_proxy="http://127.0.0.1:10808"
    export https_proxy="http://127.0.0.1:10808"
    export all_proxy="socks5://127.0.0.1:10808"
}

proxy_off() {
    unset http_proxy https_proxy all_proxy
}

proxy_on

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
alias jl='journalctl'

# Editor
alias vi='nvim'
alias vim='nvim'
alias za='zathura'

# Rust development
alias vrs='nvim src/main.rs'
alias vtm='nvim Cargo.toml'
alias cdd='cargo add'
alias cun='cargo run'
alias cud='cargo build'
alias cew='cargo new'
alias can='cargo clean'
alias cst='cargo test'

# Git
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Config files
alias hcj='nvim ~/.config/hypr/hyprland.conf'
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

#log setting
log() {
    local logdir="$HOME/Notes/logs"
    local today="$(date +%F).md"
    mkdir -p "$logdir"
    local logfile="$logdir/$today"

    if [ ! -f "$logfile" ]; then
        echo -e "# $today\n" > "$logfile"
    fi

    nvim "$logfile"
}

