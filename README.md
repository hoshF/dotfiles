# dotfiles

Personal dotfiles managed with [yadm](https://yadm.io/).

Two environments:

- **sway** — Arch Linux + Sway (primary)
- **mac** — macOS + Ghostty

The tmux configuration requires tmux 3.3 or newer.

## Stack

zsh + zim · Neovim + lazy.nvim · Sway + foot + tmux · fcitx5 + Rime · Yazi · OpenCode

## Install

Start with Git and yadm installed, and clone without running the installer:

```sh
yadm clone https://github.com/hoshF/dotfiles.git --no-bootstrap
```

### macOS: restore configuration

Install the tools and fonts you use separately. In particular, Yazi and its
matching `ya` command must be available before restoring its plugins:

```sh
yadm config --replace-all local.class mac
yadm alt
ya pkg install
```

This restores the macOS alternate files and the Yazi packages locked in
`.config/yazi/package.toml`. The bootstrap installer is Arch-only; macOS has no
automatic system package installation. The Yazi Git shortcut also requires
`lazygit`.

### Arch Linux + Sway: provision the machine

Prepare Node.js, npm and Go in the current shell before running bootstrap.
The Neovim step checks these commands and stops if any are missing; installing
`fnm` alone does not install a Node.js runtime. Use your existing runtime manager
or system packages; bootstrap does not manage their versions.

```sh
yadm config --replace-all local.class sway
yadm alt
yadm bootstrap
```

Run bootstrap as your normal user with `sudo` available. It requires the `sway`
class without a conflicting `mac` class, installs packages from
`.config/yadm/packages.yaml`, restores Yazi packages, and performs the existing
driver, Rime, service, Rust and Neovim setup. It uses Arch's official `yq`
(kislyuk/yq); an existing `paru` or `yay` is reused, otherwise `paru` is built
from the AUR as the normal user. For configuration only, omit `yadm bootstrap`
and run `ya pkg install` after installing Yazi yourself.

New Rust installations use stable with the default profile. Existing rustup
installations keep their default toolchain and components; missing components
are reported without changing them. Projects can select nightly separately.
Neovim setup verifies Mason installation records after installation and fails
if required tools are missing or their records are invalid. In Neovim, run
`:MasonToolsVerify` to repeat that check without installing anything.

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
yadm bootstrap    # provision Arch Linux + Sway (requires sudo)
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
