# Dotfiles

Personal dotfiles managed with [yadm](https://yadm.io/), designed for two environments:

- **sway** — Arch Linux + Sway (Wayland) desktop, the primary machine
- **mac** — macOS (ghostty, `open`-based tooling)

`##class.<env>` alternate templates auto-select the right file per machine.

## Install

```bash
# Prerequisites: yadm, git, and your GPG key (for encrypted files)
yadm clone https://github.com/hoshF/dotfiles.git --bootstrap
```

`--bootstrap` runs the full provisioning script (see [Bootstrap](#bootstrap)); it requires `sudo`. On an existing machine, just `yadm clone` and run `yadm alt` — no root needed for the config itself.

Encrypted secrets (`.ssh/` private keys, `.zshenv`) are stored in `archive` and decrypt automatically on clone if your GPG key is present.

## What's Inside

### Shell & Tools
- **zsh** with [zim](https://github.com/zimfw/zimfw) (`.zshrc` alternate per class, `.zimrc`, `fzf.zsh`)
- **tmux** (`.config/tmux/tmux.conf`)

### Editor — Neovim
Modular [lazy.nvim](https://github.com/folke/lazy.nvim) setup under `.config/nvim/`:

| Area | Plugins |
|---|---|
| Completion | blink.cmp + LuaSnip |
| LSP | mason + lspconfig + trouble (lua/rust/c/cpp/go/python/tex/asm/js/ts/json/yaml) |
| Formatting | conform.nvim (stylua/black/rustfmt/clang-format/prettierd/shfmt & more) |
| Syntax | treesitter |
| File tree | neo-tree |
| LaTeX | vimtex + extensive custom LuaSnip snippets (tex/markdown) |
| Editing | leap, nvim-surround, Comment.nvim, nvim-autopairs |
| Theme | nordic.nvim |

### Desktop — sway
- **sway** + swaylock + mako (notifications)
- **fcitx5 + rime** IME (classic UI, custom schema under `.local/share/fcitx5`)
- **foot** terminal
- **mpd + ncmpcpp** music

### File Manager — Yazi
- Alternate configs per class (`yazi.toml`, `keymap.toml`)
- [everforest-medium](https://github.com/Chromium-3-Oxide/everforest-medium) flavor
- Plugins: [smart-enter](https://github.com/yazi-rs/plugins) (`l` = enter/open), `md-open` (mac: open Markdown in Typora; sway: nvim)
- Openers: nvim / imv / sioyek / zathura / mpv / epr / xdg-open

### AI — Opencode
Custom agent configs (`.config/opencode/`): `executor`, `explorer`, `operator`, `reviewer`, plus a `yadm` skill for dotfile workflows. `opencode.json` alternates per class.

### Secrets
`.ssh/` private keys and `.zshenv` are tracked encrypted via `yadm encrypt` (see [`.config/yadm/encrypt`](.config/yadm/encrypt)). Only `.ssh/hoshf.pub` is tracked in plaintext.

## Environment Alternates

Files suffixed `##class.mac` / `##class.sway` are yadm alternates — `yadm alt` symlinks the matching variant based on `yadm.class`:

```
~/.config/yazi/yazi.toml##class.sway  →  ~/.config/yazi/yazi.toml   (on sway)
~/.config/yazi/yazi.toml##class.mac   →  ~/.config/yazi/yazi.toml   (on mac)
```

## Bootstrap

[`.config/yadm/bootstrap`](.config/yadm/bootstrap) is a 244-line provisioning script that:

1. Installs GPU drivers
2. Installs pacman packages by category (core / cli_tools / sway_desktop / ime / viewers / latex / fonts / audio / services / security)
3. Installs AUR packages (browser / fonts / ime / tools / security) via yay/paru
4. Sets up rime grammar & security tools, enables services, installs Rust

Package lists live in [`.config/yadm/packages.yaml`](.config/yadm/packages.yaml).

## Common Commands

```bash
yadm status               # Check status
yadm add <file>           # Stage a file
yadm commit -m "msg"      # Commit
yadm push                 # Push
yadm pull                 # Pull
yadm encrypt              # Re-encrypt sensitive files
yadm alt                  # Rebuild alternate symlinks
yadm bootstrap            # Run provisioning script
```

> ℹ️ **Note**: the remote uses an SSH host alias (`git@github.com-personal:...`); machines that can't read the system ssh config may need
> `GIT_SSH_COMMAND="ssh -F ~/.ssh/config" yadm push`.
