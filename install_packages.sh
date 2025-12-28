#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}Run with sudo${NC}"
    exit 1
fi

# Get real user
REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME=$(eval echo ~"$REAL_USER")

echo -e "${GREEN}=== Arch Setup ===${NC}"
echo "User: $REAL_USER"

# Detect proxy
PROXY_AVAILABLE=false
if [ -n "$http_proxy" ] || [ -n "$https_proxy" ] || [ -n "$all_proxy" ] || [ -n "$ALL_PROXY" ]; then
    PROXY_AVAILABLE=true
    echo -e "${GREEN}✓ Proxy detected${NC}"
else
    echo -e "${YELLOW}✗ No proxy${NC}"
fi
echo ""

# Official packages
PACMAN_PKGS=(
    # Core tools
    unzip openssh git curl wget cmake

    # Terminal & dev
    tmux yazi fzf wl-clipboard alacritty

    # Hyprland
    hyprland hypridle hyprpaper waybar wofi mako ly

    # Input method
    fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime

    # Viewers
    imv zathura zathura-pdf-poppler

    # LaTeX
    texlive texlive-langchinese texlive-latexextra texlive-fontsextra
    perl-yaml-tiny perl-file-homedir perl-unicode-string perl

    # Fonts
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
    adobe-source-han-serif-cn-fonts wqy-zenhei

    # Audio & Bluetooth
    pavucontrol bluez bluez-utils blueman
    sof-firmware alsa-firmware alsa-ucm-conf

    # Misc
    wf-recorder firefox yay paru

    # Neovim formatters
    stylua python-black python-isort clang go npm shfmt
)

# AUR packages
AUR_PKGS=(
    otf-latin-modern
    ttf-ibmplex-mono-nerd
    rime-ice
    epr
    xray
    fcitx5-skin-fluentlight-git
    fnm
)

# Go packages
GO_PKGS=(
    github.com/asmfmt/asmfmt@latest
)

# Install pacman packages
install_pacman() {
    echo -e "${GREEN}[1/6] Installing packages...${NC}"
    pacman -Syu --noconfirm || exit 1
    pacman -S --noconfirm --needed "${PACMAN_PKGS[@]}" || {
        pacman -Sy --noconfirm && pacman -S --noconfirm --needed "${PACMAN_PKGS[@]}" || exit 1
    }
}

# Configure npm registry
configure_npm() {
    echo -e "${GREEN}[2/6] Configuring npm...${NC}"
    if [ "$PROXY_AVAILABLE" = true ]; then
        npm config set registry https://registry.npmjs.org
    else
        npm config set registry https://registry.npmmirror.com
    fi
}

# Install npm packages
install_npm() {
    echo -e "${GREEN}[3/6] Installing npm tools...${NC}"
    NPM_PKGS=(prettier "@fsouza/prettierd" eslint_d eslint)
    for pkg in "${NPM_PKGS[@]}"; do
        npm install -g "$pkg" 2>/dev/null || echo -e "${YELLOW}Skip: $pkg${NC}"
    done
}

# Install Go packages
install_go_pkgs() {
    echo -e "${GREEN}[4/6] Installing Go tools...${NC}"
    
    # Check if Go is installed
    if ! command -v go &>/dev/null; then
        echo -e "${YELLOW}Go not installed, skipping Go tools${NC}"
        return
    fi
    
    # Set GOPATH if not set
    if [ -z "$GOPATH" ]; then
        export GOPATH="$REAL_HOME/go"
        export PATH="$PATH:$GOPATH/bin"
    fi
    
    # Install each Go package
    for pkg in "${GO_PKGS[@]}"; do
        echo -e "${BLUE}Installing: $pkg${NC}"
        sudo -u "$REAL_USER" go install "$pkg" 2>/dev/null || echo -e "${YELLOW}Skip: $pkg${NC}"
    done
    
    # Verify installation
    if command -v asmfmt &>/dev/null; then
        echo -e "${GREEN}✓ asmfmt installed successfully${NC}"
    else
        echo -e "${YELLOW}⚠ asmfmt may not be in PATH${NC}"
    fi
}

# Install Rust
install_rust() {
    echo -e "${GREEN}[5/6] Installing Rust...${NC}"

    # Check if rustup exists
    if sudo -u "$REAL_USER" command -v rustup &>/dev/null; then
        echo "Rust already installed (rustup)"
        return
    fi

    # Check if rustc exists but not rustup
    if sudo -u "$REAL_USER" command -v rustc &>/dev/null; then
        echo "Rust installed via pacman, skipping rustup"
        return
    fi

    # Set mirrors if no proxy
    if [ "$PROXY_AVAILABLE" = false ]; then
        export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"
        export RUSTUP_UPDATE_ROOT="https://mirrors.ustc.edu.cn/rust-static/rustup"
    fi

    # Install
    sudo -u "$REAL_USER" bash -c 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path' || {
        echo -e "${RED}Rust install failed${NC}"
        return 1
    }

    # Configure cargo mirror if no proxy
    if [ "$PROXY_AVAILABLE" = false ]; then
        CARGO_CONFIG_DIR="$REAL_HOME/.cargo"
        mkdir -p "$CARGO_CONFIG_DIR"
        cat >"$CARGO_CONFIG_DIR/config.toml" <<'EOF'
[source.crates-io]
replace-with = 'ustc'

[source.ustc]
registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"
EOF
        chown -R "$REAL_USER:$REAL_USER" "$CARGO_CONFIG_DIR"
    fi
}

# Install AUR packages
install_aur() {
    echo -e "${GREEN}[6/6] Installing AUR packages...${NC}"
    if ! command -v yay &>/dev/null; then
        echo -e "${RED}yay not found${NC}"
        exit 1
    fi
    for pkg in "${AUR_PKGS[@]}"; do
        sudo -u "$REAL_USER" yay -S --noconfirm --needed "$pkg" 2>/dev/null || echo -e "${YELLOW}Skip: $pkg${NC}"
    done

    # Update font cache
    echo -e "${BLUE}Updating font cache...${NC}"
    fc-cache -fv
}


# Summary
summary() {
    echo ""
    echo -e "${GREEN}=== Done ===${NC}"
    echo "Installed:"
    echo "  - Formatters: stylua, black, isort, clang-format, gofmt, shfmt, asmfmt"
    echo "  - Node.js: prettier, prettierd, eslint_d, eslint"
    echo "  - LaTeX: texlive"
    echo "  - IME: fcitx5 + rime-ice"
    if sudo -u "$REAL_USER" command -v rustc &>/dev/null; then
        echo "  - Rust: $(sudo -u "$REAL_USER" rustc --version 2>/dev/null | cut -d' ' -f2)"
    fi
    if command -v asmfmt &>/dev/null; then
        echo "  - Go tools: asmfmt"
    fi
    echo ""
    echo "Next:"
    echo "  1. Re-login to apply IME settings"
    echo "  2. Run :checkhealth in Neovim"
    [ -f "$REAL_HOME/.cargo/env" ] && echo "  3. source ~/.cargo/env (for Rust)"
    [ -d "$REAL_HOME/go/bin" ] && echo "  4. Add ~/go/bin to PATH (for Go tools)"
}

# Main
main() {
    install_pacman
    configure_npm
    install_npm
    install_go_pkgs
    install_rust
    install_aur
    summary
}

main
ln -sf /usr/bin/nvim /usr/bin/vi
