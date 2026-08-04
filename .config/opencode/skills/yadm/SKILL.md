---
name: yadm
description: Use when using yadm commands, managing dotfiles with yadm, or working with yadm alternate templates
---

# Yadm — Dotfiles Management

All configs managed by [yadm](https://yadm.io/) (remote: `hoshF/dotfiles`). yadm wraps git: work-tree = `$HOME`. Use `yadm` prefix for any git command.

## Alternate Templates (`yadm alt`)

yadm selects file versions via `##<condition>` suffix. Active class is determined by `yadm config local.class` (set via `yadm config local.class <class>`).

How alternates work:
- `file##class.sway` → symlinked to `file` when `local.class=sway`
- `file##class.mac` → symlinked to `file` when `local.class=mac`
- `file##default` → fallback when no class-specific match
- `yadm alt` re-creates all symlinks; runs automatically on `clone`/`pull` unless `yadm.auto-alt` is `false`

Critical rules:
- Templates use `##class.<class>` suffix
- Edit via the symlink path — yadm resolves to the template automatically
- `yadm add`/`yadm rm` use the symlink path; yadm tracks the actual template file
- **Never delete** any `##class.*` directory or file (template files)
- `yadm alt` is usually automatic; run manually only if `yadm.auto-alt` is disabled
- Active templates depend on the current class; check with `yadm ls-files | grep '##class'`

## Common Commands

| Task | Command |
|------|---------|
| Check working tree changes | `yadm status` |
| List ALL tracked files | `yadm list` (or `yadm ls-files`) |
| Show diff (unstaged) | `yadm diff` |
| Show diff (staged) | `yadm diff --cached` |
| Show recent commits | `yadm log --oneline -10` |
| Stage modified/deleted files | `yadm add -u <path>` |
| Stage new untracked files | `yadm add <path>` |
| Stage everything | `yadm add -A .` |
| Commit | `yadm commit -m "msg"` |
| Push/pull | `yadm push` / `yadm pull` |
| Encrypt/decrypt secrets | `yadm encrypt` / `yadm decrypt [-l]` |
| Re-create alt symlinks | `yadm alt` |
| Check if file is tracked | `yadm ls-files \| grep <pattern>` |

## Key Conventions

- Prefer `yadm add -u` over `yadm add -A` — only stages modified/deleted files, not untracked. Use explicit `yadm add <path>` for new files.
- `yadm status` only shows changed/untracked files. Use `yadm list`/`yadm ls-files` to confirm a file IS tracked.
