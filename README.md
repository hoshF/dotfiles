# Dotfiles

个人 dotfiles 仓库，通过 [yadm](https://yadm.io/) 管理，配置 [opencode](https://github.com/superpowers/opencode) + superpowers agent 工作流。

## 安装

```bash
yadm clone https://github.com/hoshF/dotfiles.git --bootstrap
```

## 配置清单

### Shell
zsh（`.zshrc`）、zim（`.zimrc`）、fzf 集成

### 编辑器 — Neovim
基于 lazy.nvim 的模块化配置：

- **补全**: blink.cmp + LuaSnip
- **LSP**: mason + lspconfig（lua/rust/c/cpp/go/python/tex/asm/js/ts/json/yaml）
- **格式化**: conform.nvim（stylua/black/rustfmt/clang-format/prettierd/shfmt 等）
- **语法**: treesitter
- **文件树**: neo-tree
- **LaTeX**: vimtex + 大量自定义 LuaSnip snippet（tex/markdown）
- **编辑增强**: leap、nvim-surround、Comment.nvim、nvim-autopairs
- **主题**: nordic.nvim

### 终端
foot (Sway) / ghostty (macOS)

### 桌面 — Sway
sway + waybar + swaylock + mako 通知 + fcitx5 (rime)

### AI 工具 — Opencode
自定义 agent 配置（orchestrator / executor / explorer / reviewer / operator），集成 superpowers 技能系统

### 媒体
mpd + ncmpcpp

### 其他
yazi（文件管理器）、tmux、git、ssh

## 目录结构

```
~
├── .config/
│   ├── nvim/            # Neovim 配置 (lazy.nvim)
│   ├── yazi/            # 文件管理器
│   ├── opencode/        # Opencode agents
│   ├── sway/            # Sway WM (##class.sway)
│   ├── foot/            # 终端 (##class.sway)
│   ├── ghostty/         # 终端 (##class.mac)
│   ├── fcitx5/          # 输入法 (##class.sway)
│   ├── mako/            # 通知 (##class.sway)
│   ├── mpd/             # 音乐 (##class.sway)
│   ├── ncmpcppd/        # 音乐客户端 (##class.sway)
│   ├── tmux/
│   └── yadm/            # bootstrap, encrypt
├── .zshrc               # Shell 配置 (##class.mac / ##class.sway)
├── .zimrc               # Zim 框架
└── .ssh/                # SSH 密钥 (加密)
```

`##class.<os>` 后缀为 yadm alternate templates，克隆时根据系统自动选择对应版本。

## 常用命令

```bash
yadm status               # 查看状态
yadm add <file>           # 添加文件
yadm commit -m "msg"      # 提交
yadm push                 # 推送
yadm encrypt              # 加密敏感文件
yadm alt                  # 重新生成 alternate 模板链接
```
