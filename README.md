# dotfiles

Personal dotfiles managed with [yadm](https://yadm.io/).

Two environments:

- **sway** — Arch Linux + Sway (primary)
- **mac** — macOS + Ghostty

## Stack

zsh + zim · Neovim + lazy.nvim · Sway + foot + tmux · fcitx5 + Rime · Yazi · OpenCode

## Install

```sh
yadm clone https://github.com/hoshF/dotfiles.git --bootstrap
```

`--bootstrap` installs packages from `.config/yadm/packages.yaml` and requires `sudo`.
For config only, clone without `--bootstrap` and run `yadm alt`.

Secrets (`.ssh/` private keys, `.zshenv`) are GPG-encrypted in `.local/share/yadm/archive`.
Only `.ssh/hoshf.pub` is stored in plaintext under `.ssh/`.
Shared SSH defaults are stored in `.config/ssh/terminal.conf`.

## Layout

```text
.config/            app configs (sway, foot, tmux, fcitx5, nvim, yazi, opencode)
.config/yadm/       bootstrap, packages.yaml, encrypt list
.zshrc##class.*     shell entry per environment
.zimrc, fzf.zsh     zsh
```

Files ending in `##class.<env>` are yadm alternates. `yadm alt` links the active
variant; configs use file-level links and keep runtime data in real directories.

## Notes

- Terminal font: **Maple Mono NF CN**; UI, notifications and browser body: **Noto**.
- Sway uses greetd auto-login, no greeter.
- The remote uses the `github.com-personal` SSH alias. If unavailable:
  `GIT_SSH_COMMAND="ssh -F ~/.ssh/config" yadm push`
- After changing encrypted files: `yadm encrypt`.

## Common commands

```sh
yadm status       # changes
yadm alt          # rebuild alternate links
yadm bootstrap    # provision a new machine
yadm encrypt      # re-encrypt secrets
```

## SSH terminal compatibility

macOS/Ghostty and Sway/foot share `.config/ssh/terminal.conf`, which uses
`SetEnv TERM=xterm-256color` for all SSH destinations (OpenSSH >= 8.7).
New VPS hosts need no Ghostty or foot terminfo installation. Local terminal
capabilities stay unchanged; SSH sessions use the common xterm feature set.

The yadm `post_clone`, `post_pull`, `post_alt`, and `post_decrypt` hooks add an
Include at the top of the private `~/.ssh/config`, without duplicating it or
exposing host entries. After updating an existing checkout, run `yadm alt`
once, then reconnect SSH. No shell wrapper or global TERM override is needed.

The Include is restored after decrypting an older archive. When next updating
secrets, run `yadm encrypt` as usual to also save the Include in the archive.
