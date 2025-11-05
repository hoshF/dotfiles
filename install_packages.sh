#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script with sudo!"
    exit 1
fi

# Official pacman package list
PACMAN_PKGS=(
    openssh ly git curl cmake yazi tmux mako hyprland hypridle hyprpaper waybar wofi alacritty fzf wl-clipboard yay
    fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime paru imv zathura zathura-pdf-mupdf texlive texlive-langchinese texlive-latexextra
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra adobe-source-han-serif-cn-fonts wqy-zenhei
    pavucontrol bluez bluez-utils blueman
    perl-yaml-tiny perl-file-homedir perl-unicode-string
    wf-recorder
    sof-firmware alsa-firmware alsa-ucm-conf firefox
)

# AUR package list (installed via yay)
AUR_PKGS=(
    xray ttf-ibmplex-mono-nerd rime-ice epr
)

# Install pacman packages
echo "Installing official pacman packages..."
pacman -S --noconfirm --needed "${PACMAN_PKGS[@]}" || {
    echo "Some pacman packages failed to install. Trying to sync the database and retrying..."
    pacman -Sy --noconfirm && pacman -S --noconfirm --needed "${PACMAN_PKGS[@]}" || exit 1
}

# Install AUR packages via yay
if command -v yay &> /dev/null; then
    echo "Installing AUR packages via yay..."
    sudo -u "$SUDO_USER" yay -S --noconfirm --needed "${AUR_PKGS[@]}" || exit 1
else
    echo "yay is not installed. Please install the AUR packages manually: ${AUR_PKGS[*]}"
    exit 1
fi

# Install fnm and latest Node.js
if command -v fnm &> /dev/null; then
    echo "Installing/updating the latest stable Node.js..."
    fnm install --lts || exit 1
else
    echo "fnm is not installed. Skipping Node.js installation."
fi

# Configure Rime to use rime-ice
echo "Configuring Rime input method..."
mkdir -p ~/.local/share/fcitx5/rime
cat > ~/.local/share/fcitx5/rime/default.custom.yaml << "EOF"
patch:
  __include: rime_ice_suggestion:/

  __patch::
    menu/page_size: 8
EOF

# Install the Rime skin using paru
if command -v paru &> /dev/null; then
    echo "Installing fcitx5-skin-fluentlight-git via paru..."
    sudo -u "$SUDO_USER" paru -S --noconfirm fcitx5-skin-fluentlight-git || exit 1
else
    echo "paru is not installed. Please install it and try again."
    exit 1
fi

echo "Installation complete! Please log out and log back in to apply the input method and set your theme."

# # Install the Rust
# if command -v curl &> /dev/null; then
#     echo "Installing Rust"
#     sudo -u "$SUDO_USER" curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# else
#     echo "curl is not installed. Please install it and try again."
#     exit 1
# fi
#
# echo "Rust installed!!!"
