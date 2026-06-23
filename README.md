# Dotfiles

Personal dotfiles managed with [yadm](https://yadm.io/), featuring [opencode](https://github.com/superpowers/opencode) + superpowers agent workflow.

## Install

```bash
yadm clone https://github.com/hoshF/dotfiles.git --bootstrap
```

## What's Inside

### Shell
zsh (`.zshrc`), zim (`.zimrc`), fzf integration

### Editor — Neovim
Modular lazy.nvim setup:

- **Completion**: blink.cmp + LuaSnip
- **LSP**: mason + lspconfig (lua/rust/c/cpp/go/python/tex/asm/js/ts/json/yaml)
- **Formatting**: conform.nvim (stylua/black/rustfmt/clang-format/prettierd/shfmt & more)
- **Syntax**: treesitter
- **File tree**: neo-tree
- **LaTeX**: vimtex + extensive custom LuaSnip snippets (tex/markdown)
- **Editing**: leap, nvim-surround, Comment.nvim, nvim-autopairs
- **Theme**: nordic.nvim

### Terminal
foot (Sway) / ghostty (macOS)

### Desktop — Sway
sway + waybar + swaylock + mako notifications + fcitx5 (rime)

### AI — Opencode
Custom agent configs (orchestrator / executor / explorer / reviewer / operator) with superpowers skill system

### Media
mpd + ncmpcpp

### Misc
yazi (file manager), tmux, git, ssh

## Directory Structure

```
~
├── .config/
│   ├── nvim/            # Neovim config (lazy.nvim)
│   ├── yazi/            # File manager
│   ├── opencode/        # Opencode agents
│   ├── sway/            # Sway WM (##class.sway)
│   ├── foot/            # Terminal (##class.sway)
│   ├── ghostty/         # Terminal (##class.mac)
│   ├── fcitx5/          # IME (##class.sway)
│   ├── mako/            # Notifications (##class.sway)
│   ├── mpd/             # Music (##class.sway)
│   ├── ncmpcppd/        # Music client (##class.sway)
│   ├── tmux/
│   └── yadm/            # bootstrap, encrypt
├── .zshrc               # Shell config (##class.mac / ##class.sway)
├── .zimrc               # Zim framework
└── .ssh/                # SSH keys (encrypted)
```

`##class.<os>` suffixes are yadm alternate templates — the right version is auto-selected on clone based on the target OS.

## Common Commands

```bash
yadm status               # Check status
yadm add <file>           # Stage a file
yadm commit -m "msg"      # Commit
yadm push                 # Push
yadm encrypt              # Encrypt sensitive files
yadm alt                  # Rebuild alternate symlinks
```
