#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Logging
LOG_FILE="/tmp/arch-setup-$(date +%Y%m%d-%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Installation log: $LOG_FILE"

# Error handling
set -E
trap 'echo -e "${RED}Installation failed! Check log: $LOG_FILE${NC}"' ERR

# Check root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}Please run with sudo${NC}"
    exit 1
fi

# Get real user
REAL_USER="${SUDO_USER:-$USER}"
REAL_HOME=$(eval echo ~"$REAL_USER")
REAL_GROUP=$(id -gn "$REAL_USER")

# Configuration variables
INSTALL_DE="" # sway/hyprland/none

echo -e "${CYAN}================================${NC}"
echo -e "${CYAN}   Arch Linux Setup Script${NC}"
echo -e "${CYAN}================================${NC}"
echo "User: $REAL_USER"
echo "Group: $REAL_GROUP"
echo ""

# ========================
#   Package Definitions
# ========================

# Core packages (always install)
PACMAN_CORE=(
    # Basic tools
    base-devel
    git
    curl
    wget
    openssh
    unzip
    libnotify

    # Terminal tools
    tmux
    yazi
    fzf
    wl-clipboard

    # Development
    cmake
    go
)

# Optional packages
PACMAN_IME=(
    fcitx5
    fcitx5-configtool
    fcitx5-gtk
    fcitx5-qt
    fcitx5-rime
)

PACMAN_VIEWERS=(
    imv
    zathura
    zathura-pdf-poppler
)

PACMAN_LATEX=(
    texlive-basic
    texlive-latex
    texlive-latexrecommended
    texlive-langchinese
    texlive-fontsrecommended
)

PACMAN_FONTS=(
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    adobe-source-han-serif-cn-fonts
    wqy-zenhei
    ttf-dejavu
    ttf-liberation
)

PACMAN_AUDIO=(
    pipewire
    pipewire-alsa
    pipewire-pulse
    pipewire-jack
    pipewire-audio
    wireplumber

    bluez
    bluez-utils
    blueman

    sof-firmware
)

PACMAN_FORMATTERS=(
    stylua
    python-black
    python-isort
    clang
    shfmt
)

PACMAN_COMMON=(
    wf-recorder
    firefox
)

# Desktop Environment packages
PACMAN_SWAY=(
    sway
    swaylock
    swayidle
    swaybg
    waybar
    mako
    xorg-xwayland
    polkit-gnome
    qt5-wayland
    qt6-wayland
    grim
    slurp
)

PACMAN_HYPRLAND=(
    alacritty
    hyprland
    waybar
    wofi
    mako
    xorg-xwayland
    polkit-gnome
    qt5-wayland
    qt6-wayland
    hyprpaper
    grim
    slurp
)

# AUR packages
AUR_FONTS=(
    otf-latin-modern
    ttf-ibmplex-mono-nerd
)

AUR_IME=(
    rime-ice
    fcitx5-skin-fluentlight-git
)

AUR_TOOLS=(
    epr
    xray
    fnm
)

# Go packages
GO_PKGS=(
    github.com/klauspost/asmfmt/cmd/asmfmt@latest
)

# ========================
#   Interactive Menu
# ========================

show_menu() {
    echo -e "${YELLOW}=== Desktop Environment Selection ===${NC}"
    echo "1) Install Sway (Tiling window manager)"
    echo "2) Install Hyprland (Modern tiling compositor)"
    echo "3) Skip desktop environment"
    echo ""
    read -p "Select (1/2/3) [default: 3]: " de_choice

    case ${de_choice:-3} in
        1)
            INSTALL_DE="sway"
            echo -e "${GREEN}✓ Will install Sway${NC}"
            ;;
        2)
            INSTALL_DE="hyprland"
            echo -e "${GREEN}✓ Will install Hyprland${NC}"
            ;;
        *)
            INSTALL_DE="none"
            echo -e "${BLUE}✓ Skip desktop environment${NC}"
            ;;
    esac
    echo ""

    # Confirmation
    echo -e "${CYAN}=== Installation Summary ===${NC}"
    echo "Desktop Environment: $INSTALL_DE"
    echo "Will install:"
    echo "  - Core tools (git, tmux, yazi, fzf, etc.)"
    echo "  - Input method (fcitx5 + rime)"
    echo "  - Fonts (Noto, CJK, etc.)"
    echo "  - LaTeX (texlive)"
    echo "  - Viewers (zathura, imv)"
    echo "  - Audio/Bluetooth (pipewire, bluez)"
    echo "  - Code formatters (stylua, black, clang-format, etc.)"
    [ "$INSTALL_DE" != "none" ] && echo "  - $INSTALL_DE desktop environment"
    echo ""
    echo "Note: Using China mirrors for faster download"
    echo ""

    read -p "Confirm installation? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${RED}Installation cancelled${NC}"
        exit 0
    fi
    echo ""
}

# ========================
# Installation Functions
# ========================

install_pacman_packages() {
    echo -e "${GREEN}[1/5] Installing Pacman packages${NC}"

    # Update system
    echo -e "${BLUE}Updating system...${NC}"
    pacman -Syu --noconfirm || {
        echo -e "${RED}System update failed${NC}"
        exit 1
    }

    # Combine all packages to install
    local all_pkgs=(
        "${PACMAN_CORE[@]}"
        "${PACMAN_IME[@]}"
        "${PACMAN_VIEWERS[@]}"
        "${PACMAN_LATEX[@]}"
        "${PACMAN_FONTS[@]}"
        "${PACMAN_AUDIO[@]}"
        "${PACMAN_FORMATTERS[@]}"
        "${PACMAN_COMMON[@]}"
    )

    # Add desktop environment packages
    if [ "$INSTALL_DE" = "sway" ]; then
        echo -e "${BLUE}Adding Sway packages...${NC}"
        all_pkgs+=("${PACMAN_SWAY[@]}")
    elif [ "$INSTALL_DE" = "hyprland" ]; then
        echo -e "${BLUE}Adding Hyprland packages...${NC}"
        all_pkgs+=("${PACMAN_HYPRLAND[@]}")
    fi

    # Install all packages
    echo -e "${BLUE}Installing ${#all_pkgs[@]} packages...${NC}"
    local failed_pkgs=()

    if ! pacman -S --noconfirm --needed "${all_pkgs[@]}"; then
        echo -e "${YELLOW}Some packages failed to install${NC}"
        # Try to identify which packages failed
        for pkg in "${all_pkgs[@]}"; do
            if ! pacman -Q "$pkg" &> /dev/null; then
                failed_pkgs+=("$pkg")
            fi
        done

        if [ ${#failed_pkgs[@]} -gt 0 ]; then
            echo -e "${YELLOW}Failed packages: ${failed_pkgs[*]}${NC}"
        fi
    fi

    echo -e "${GREEN}✓ Pacman packages installed${NC}"

    # Verify critical packages
    local critical_pkgs=(git curl base-devel)
    local missing_critical=()

    for pkg in "${critical_pkgs[@]}"; do
        if ! pacman -Q "$pkg" &> /dev/null; then
            missing_critical+=("$pkg")
        fi
    done

    if [ ${#missing_critical[@]} -gt 0 ]; then
        echo -e "${RED}Critical packages missing: ${missing_critical[*]}${NC}"
        echo -e "${RED}Cannot continue without these packages${NC}"
        exit 1
    fi
}

install_aur_helper() {
    echo -e "${GREEN}[2/5] Installing AUR helper${NC}"

    # Check if yay exists
    if command -v yay &> /dev/null; then
        echo "yay already installed"
        echo -e "${BLUE}Current version: $(yay --version | head -n1)${NC}"
        return
    fi

    # Install yay
    local build_dir="/tmp/yay-build-$$"
    mkdir -p "$build_dir"

    echo -e "${BLUE}Building yay...${NC}"
    sudo -u "$REAL_USER" bash -c "
        cd '$build_dir' && \
        git clone https://aur.archlinux.org/yay.git && \
        cd yay && \
        makepkg -si --noconfirm
    " || {
        echo -e "${RED}yay installation failed${NC}"
        rm -rf "$build_dir"
        exit 1
    }

    rm -rf "$build_dir"
    echo -e "${GREEN}✓ yay installed${NC}"

    # Note: Removed AUR mirror configuration as Tsinghua mirror is no longer available
    # Using default AUR repository
    echo -e "${BLUE}Using official AUR repository${NC}"
}

install_aur_packages() {
    echo -e "${GREEN}[3/5] Installing AUR packages${NC}"

    if ! command -v yay &> /dev/null; then
        echo -e "${RED}yay not installed, AUR packages will be skipped${NC}"
        echo -e "${YELLOW}The following AUR packages were not installed:${NC}"
        echo -e "${YELLOW}  Fonts: ${AUR_FONTS[*]}${NC}"
        echo -e "${YELLOW}  IME: ${AUR_IME[*]}${NC}"
        echo -e "${YELLOW}  Tools: ${AUR_TOOLS[*]}${NC}"
        return
    fi

    # Collect all AUR packages
    local all_aur_pkgs=(
        "${AUR_FONTS[@]}"
        "${AUR_IME[@]}"
        "${AUR_TOOLS[@]}"
    )

    # Track installation status
    local installed=()
    local failed=()
    local skipped=()

    # Install AUR packages
    for pkg in "${all_aur_pkgs[@]}"; do
        # Check if already installed
        if pacman -Qi "$pkg" &> /dev/null; then
            echo -e "${BLUE}Already installed: $pkg${NC}"
            skipped+=("$pkg")
            continue
        fi

        echo -e "${BLUE}Installing: $pkg${NC}"
        if sudo -u "$REAL_USER" yay -S --noconfirm --needed "$pkg"; then
            installed+=("$pkg")
            echo -e "${GREEN}✓ Installed: $pkg${NC}"
        else
            failed+=("$pkg")
            echo -e "${YELLOW}✗ Failed: $pkg${NC}"
        fi
    done

    # Summary
    echo ""
    echo -e "${CYAN}AUR Installation Summary:${NC}"
    [ ${#installed[@]} -gt 0 ] && echo -e "${GREEN}Installed (${#installed[@]}): ${installed[*]}${NC}"
    [ ${#skipped[@]} -gt 0 ] && echo -e "${BLUE}Skipped (${#skipped[@]}): ${skipped[*]}${NC}"
    [ ${#failed[@]} -gt 0 ] && echo -e "${YELLOW}Failed (${#failed[@]}): ${failed[*]}${NC}"
    echo ""

    echo -e "${GREEN}✓ AUR package installation complete${NC}"
}

update_font_cache() {
    echo -e "${BLUE}Updating font cache...${NC}"
    if fc-cache -fv > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Font cache updated${NC}"
    else
        echo -e "${YELLOW}Font cache update failed (non-critical)${NC}"
    fi
}

install_go_packages() {
    echo -e "${GREEN}[4/5] Installing Go tools${NC}"

    if ! command -v go &> /dev/null; then
        echo -e "${YELLOW}Go not installed, skipping Go packages${NC}"
        echo -e "${YELLOW}Skipped packages: ${GO_PKGS[*]}${NC}"
        return
    fi

    # Set GOPATH
    local gopath="$REAL_HOME/go"
    export GOPATH="$gopath"
    export PATH="$PATH:$gopath/bin"
    export GOPROXY=https://goproxy.cn,direct

    echo -e "${BLUE}Using China Go proxy: goproxy.cn${NC}"
    echo -e "${BLUE}GOPATH: $gopath${NC}"

    # Track installation
    local installed=()
    local failed=()

    # Install Go packages
    for pkg in "${GO_PKGS[@]}"; do
        local pkg_name=$(echo "$pkg" | awk -F'/' '{print $NF}' | cut -d'@' -f1)

        if [ -f "$gopath/bin/$pkg_name" ]; then
            echo -e "${BLUE}Already installed: $pkg_name${NC}"
            continue
        fi

        echo -e "${BLUE}Installing: $pkg${NC}"

        if env GOPATH="$gopath" PATH="$PATH:$gopath/bin" GOPROXY="https://goproxy.cn,direct" \
            go install "$pkg"; then
            installed+=("$pkg_name")
            echo -e "${GREEN}✓ Installed: $pkg_name${NC}"
        else
            failed+=("$pkg_name")
            echo -e "${YELLOW}✗ Failed: $pkg_name${NC}"
        fi
    done

    # Summary
    if [ ${#failed[@]} -ne 0 ]; then
        echo -e "${YELLOW}Failed packages: ${failed[*]}${NC}"
    fi
}

install_rust() {
    echo -e "${GREEN}[5/5] Installing Rust (nightly)${NC}"

    # Check if rustup exists
    if sudo -u "$REAL_USER" command -v rustup &> /dev/null; then
        echo "rustup already installed"

        # Check current toolchain
        local current_toolchain=$(sudo -u "$REAL_USER" bash -c 'source "$HOME/.cargo/env" 2>/dev/null || true; rustup show active-toolchain 2>/dev/null' | head -n1)
        echo -e "${BLUE}Current toolchain: $current_toolchain${NC}"

        # Switch to nightly if not already
        if [[ ! "$current_toolchain" =~ nightly ]]; then
            echo -e "${BLUE}Switching to nightly channel...${NC}"
            sudo -u "$REAL_USER" bash -c '
                source "$HOME/.cargo/env" 2>/dev/null || true
                rustup default nightly
            '
            echo -e "${GREEN}✓ Switched to nightly${NC}"
        else
            echo -e "${GREEN}✓ Already using nightly${NC}"
        fi
        return
    fi

    # Check if rustc exists (system package)
    if sudo -u "$REAL_USER" command -v rustc &> /dev/null; then
        echo "Rust already installed (system package)"
        local rust_version=$(rustc --version 2> /dev/null)
        echo -e "${BLUE}Version: $rust_version${NC}"
        echo -e "${YELLOW}Note: System Rust is stable, not nightly${NC}"
        echo -e "${YELLOW}To use nightly, install rustup and run: rustup default nightly${NC}"
        return
    fi

    echo -e "${BLUE}Installing rustup (nightly) with China mirror...${NC}"

    # Use USTC mirror and install nightly
    if sudo -u "$REAL_USER" bash -c '
        export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"
        export RUSTUP_UPDATE_ROOT="https://mirrors.ustc.edu.cn/rust-static/rustup"
        curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path --default-toolchain nightly
    '; then
        echo -e "${GREEN}✓ Rustup installed${NC}"
    else
        echo -e "${RED}Rust installation failed${NC}"
        return 1
    fi

    # Configure cargo mirror
    local cargo_config="$REAL_HOME/.cargo/config.toml"
    sudo -u "$REAL_USER" mkdir -p "$REAL_HOME/.cargo"
    cat > "$cargo_config" << 'EOF'
[source.crates-io]
replace-with = 'ustc'

[source.ustc]
registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"
EOF
    # Fixed: Use proper chown syntax with group
    chown "$REAL_USER:$REAL_GROUP" "$cargo_config"
    echo -e "${BLUE}Configured Cargo China mirror (USTC)${NC}"

    # Verify nightly installation
    local rust_version=$(sudo -u "$REAL_USER" bash -c 'source "$HOME/.cargo/env" 2>/dev/null; rustc --version' 2> /dev/null)
    if [[ "$rust_version" =~ nightly ]]; then
        echo -e "${GREEN}✓ Rust nightly installed: $rust_version${NC}"
    else
        echo -e "${YELLOW}Warning: Rust installed but may not be nightly: $rust_version${NC}"
    fi
}

# ========================
# Configuration Functions
# ========================

configure_ime() {
    echo -e "${GREEN}[Config] Configuring input method${NC}"

    local env_file="/etc/environment"

    # Check if IME variables are already configured
    local ime_configured=false
    if [ -f "$env_file" ]; then
        if grep -q "GTK_IM_MODULE.*fcitx" "$env_file" \
            && grep -q "QT_IM_MODULE.*fcitx" "$env_file" \
            && grep -q "XMODIFIERS.*fcitx" "$env_file"; then
            ime_configured=true
        fi
    fi

    if [ "$ime_configured" = true ]; then
        echo -e "${BLUE}IME environment variables already configured${NC}"
        return
    fi

    # Add IME environment variables
    cat >> "$env_file" << 'EOF'

# Fcitx5 Input Method
XMODIFIERS=@im=fcitx
GLFW_IM_MODULE=fcitx
EOF
    echo -e "${BLUE}Added IME environment variables to /etc/environment${NC}"
    echo -e "${YELLOW}Note: Re-login required for changes to take effect${NC}"
}

setup_neovim() {
    echo -e "${GREEN}[Config] Setting up Neovim symlink${NC}"

    if command -v nvim &> /dev/null; then
        if [ -L /usr/bin/vi ]; then
            local current_target=$(readlink /usr/bin/vi)
            if [ "$current_target" = "/usr/bin/nvim" ]; then
                echo -e "${BLUE}Symlink already configured: vi -> nvim${NC}"
                return
            else
                echo -e "${YELLOW}Symlink exists but points to: $current_target${NC}"
                echo -e "${YELLOW}Updating to nvim...${NC}"
            fi
        fi

        ln -sf /usr/bin/nvim /usr/bin/vi
        echo -e "${GREEN}✓ Created symlink: vi -> nvim${NC}"
    else
        echo -e "${YELLOW}nvim not installed, skipping symlink${NC}"
    fi
}

# ========================
#      Verification
# ========================

verify_installation() {
    echo -e "${GREEN}[Verify] Checking installation${NC}"

    local critical_tools=(git curl tmux)
    local missing=()

    for tool in "${critical_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing+=("$tool")
        fi
    done

    if [ ${#missing[@]} -gt 0 ]; then
        echo -e "${RED}Critical tools missing: ${missing[*]}${NC}"
        echo -e "${RED}Installation may be incomplete${NC}"
        return 1
    fi

    echo -e "${GREEN}✓ Critical tools verified${NC}"
    return 0
}

# ========================
#        Summary
# ========================

show_summary() {
    echo ""
    echo -e "${CYAN}================================${NC}"
    echo -e "${CYAN}    Installation Complete!${NC}"
    echo -e "${CYAN}================================${NC}"
    echo ""

    echo -e "${GREEN}Installed components:${NC}"
    echo ""

    # Desktop Environment
    if [ "$INSTALL_DE" != "none" ]; then
        echo "  ✓ Desktop Environment: $INSTALL_DE"
        echo ""
    fi

    # Tools
    echo "  ✓ Core tools: git, tmux, yazi, fzf"
    echo "  ✓ Input method: fcitx5 + rime-ice"
    echo "  ✓ LaTeX: texlive (full)"
    echo "  ✓ Viewers: zathura, imv"
    echo "  ✓ Audio/Bluetooth: pipewire, bluez"
    echo ""

    # Formatters
    echo "  Code formatters:"
    command -v stylua &> /dev/null && echo "    - stylua (Lua)"
    command -v black &> /dev/null && echo "    - black (Python)"
    command -v isort &> /dev/null && echo "    - isort (Python imports)"
    command -v clang-format &> /dev/null && echo "    - clang-format (C/C++)"
    command -v gofmt &> /dev/null && echo "    - gofmt (Go)"
    command -v shfmt &> /dev/null && echo "    - shfmt (Shell)"
    [ -f "$REAL_HOME/go/bin/asmfmt" ] && echo "    - asmfmt (Assembly)"
    echo ""

    # Languages
    if sudo -u "$REAL_USER" bash -c 'command -v rustc' &> /dev/null; then
        local rust_version=$(sudo -u "$REAL_USER" bash -c 'source "$HOME/.cargo/env" 2>/dev/null || true; rustc --version 2>/dev/null' | awk '{print $2}')
        local rust_channel="unknown"
        if sudo -u "$REAL_USER" bash -c 'command -v rustup' &> /dev/null; then
            rust_channel=$(sudo -u "$REAL_USER" bash -c 'source "$HOME/.cargo/env" 2>/dev/null || true; rustup show active-toolchain 2>/dev/null' | awk '{print $1}')
        fi
        echo "  ✓ Rust ($rust_version - $rust_channel)"
    fi

    if command -v go &> /dev/null; then
        echo "  ✓ Go ($(go version | awk '{print $3}'))"
    fi
    echo ""

    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. Re-login to apply environment variables"
    echo "  2. Configure input method: fcitx5-configtool"

    if [ "$INSTALL_DE" != "none" ]; then
        echo "  3. Setup your $INSTALL_DE config files"
        case "$INSTALL_DE" in
            sway)
                echo "     Config location: ~/.config/sway/config"
                echo "     Launch: Run 'sway' in TTY"
                ;;
            hyprland)
                echo "     Config location: ~/.config/hypr/hyprland.conf"
                echo "     Launch: Run 'Hyprland' in TTY"
                ;;
        esac
    fi

    if [ -f "$REAL_HOME/.cargo/env" ]; then
        echo "  4. Enable Rust in current shell: source ~/.cargo/env"
    fi

    if command -v nvim &> /dev/null; then
        echo "  5. Check Neovim health: nvim and run :checkhealth"
    fi

    echo ""
    echo -e "${BLUE}Tips:${NC}"
    [ "$INSTALL_DE" = "sway" ] && echo "  - Sway examples: https://github.com/swaywm/sway/wiki"
    [ "$INSTALL_DE" = "hyprland" ] && echo "  - Hyprland examples: https://wiki.hyprland.org/"
    echo "  - Fcitx5 config: Right-click tray icon -> Configure"
    echo "  - Rime config: ~/.local/share/fcitx5/rime/"
    echo ""
    echo -e "${GREEN}All mirrors configured for China region${NC}"
    echo -e "${BLUE}Installation log saved to: $LOG_FILE${NC}"
    echo ""
}

# ========================
#          Main
# ========================

main() {
    show_menu
    install_pacman_packages
    install_aur_helper
    install_aur_packages
    update_font_cache
    install_go_packages
    install_rust
    configure_ime
    setup_neovim
    verify_installation
    show_summary
}

main
