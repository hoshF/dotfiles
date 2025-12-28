#https://github.com/bee-san/RustScan.git Basic zsh settings
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
# export ALL_PROXY="$all_proxy"
export HTTP_PROXY="http://127.0.0.1:7890"
export HTTPS_PROXY="http://127.0.0.1:7890"
# export all_proxy="socks5://127.0.0.1:7890"
export PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
export PIP_TRUSTED_HOST=pypi.tuna.tsinghua.edu.cn

export LIBVA_DRIVER_NAME=nvidia
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export WLR_NO_HARDWARE_CURSORS=1
export QT_OPENGL=egl
export EGL_PLATFORM=wayland

export CARGO_HOME="$HOME/.cargo"
export RUSTUP_HOME="$HOME/.rustup"

export EDITOR='nvim'

export TEXINPUTS="$HOME/.config/LaTeX//:"
path=(
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    $path
)
export PATH

# Node.js version manager
command -v fnm >/dev/null && eval "$(fnm env --use-on-cd)"

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
alias dirt='all_proxy=""'

# Editor
alias vi='nvim'
alias vim='nvim'
alias za='zathura'
alias mc='ncmpcpp'


# Rust development
alias rlib='cd $(rustc --print sysroot)/lib/rustlib/src/rust/library/'
alias vrs='nvim src/main.rs'
alias vtm='nvim Cargo.toml'
alias cdd='cargo add'
alias cun='cargo run'
alias cud='cargo build'
alias cew='cargo new'
alias can='cargo clean'
alias cst='cargo test'
alias cbd='cargo build'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Config files
alias hcj='nvim ~/.config/hypr/hyprland.conf'
alias zrc='nvim ~/.zshrc'
alias tx='nvim ~/.config/tmux/tmux.conf'

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

# exercism setting
exercism () {
    local out
    local IFS=$'\n'
    out=($(command exercism "$@"))
    printf '%s\n' "${out[@]}"
    if [[ $1 == "download" && -d "${out[-1]}" ]]; then
        cd "${out[-1]}" || return 1
    fi
}

# opam
[[ ! -r '/home/nore/.opam/opam-init/init.zsh' ]] || source '/home/nore/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

alias msfconsole="pushd $HOME/git/metasploit-framework && ./msfconsole && popd"

