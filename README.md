# Dotfiles Management with yadm

This repository contains my dotfiles managed with [yadm](https://yadm.io/) - a tool that uses Git to manage dotfiles with additional features for encryption and bootstrapping.

## Installation

```bash
# Clone and bootstrap
yadm clone https://github.com/hoshF/dotfiles.git --bootstrap
```

## Repository Structure

```
dotfiles/
├── .config/           # Application configs
├── .zshrc             # Shell configs
└── .yadm/             # yadm-specific files
    ├── bootstrap      # Bootstrap script
    └── encrypt        # Files to encrypt
```

## Common Commands

```bash
yadm status                    # Check status
yadm add ~/.zshrc              # Add file
yadm commit -m "message"       # Commit changes
yadm push/pull                  # Sync with remote
yadm encrypt/decrypt           # Handle sensitive files
yadm bootstrap                  # Run setup script
```

## Key Features

- **Bootstrap**: Automatic environment setup after clone
- **Encryption**: Secure sensitive data with GPG
- **Alternate files**: OS/host-specific configs using `##` suffix

## Resources

- [yadm Documentation](https://yadm.io/docs/)
- [yadm GitHub](https://github.com/TheLocehiliosan/yadm)
