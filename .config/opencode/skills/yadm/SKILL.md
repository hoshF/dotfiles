---
name: yadm
description: Use when using yadm commands, managing dotfiles with yadm, or working with yadm alternate templates
---

# Yadm — Dotfiles Management

All configs managed by [yadm](https://yadm.io/) (remote: `hoshF/dotfiles`). yadm wraps git: work-tree = `$HOME`.
本用户的 dotfiles 仓库使用 `yadm`；普通 Git 项目仍使用项目自己的 `git`，不要把项目命令切换到 dotfiles 仓库。

## Alternate Templates (`yadm alt`)

yadm selects file versions via `##<condition>` suffix. Active class is determined by `yadm config local.class` (set via `yadm config local.class <class>`).

How alternates work:
- `file##class.sway` → symlinked to `file` when `local.class=sway`
- `file##class.mac` → symlinked to `file` when `local.class=mac`
- `file##default` → fallback when no class-specific match
- `yadm alt` re-creates all symlinks; runs automatically on `clone`/`pull` unless `yadm.auto-alt` is `false`

Critical rules:
- Templates use `##class.<class>` suffix
- 编辑已有软链路径时，通常由编辑器或操作系统跟随软链写入源文件；这不是 yadm 的路径自动映射。编辑后确认软链仍存在，实际改动位于预期源文件。
- `yadm add` / `yadm rm` 不会把软链路径自动映射到 alternate 源文件。使用 `yadm ls-files` 确认真实追踪路径，再显式操作，例如 `yadm add -- '.zshrc##class.mac'`；生成的 `.zshrc` 软链通常被排除，不应暂存。
- 不随意删除 `##class.*` 源文件或目录；仅在用户明确授权的删除或迁移任务中移除相应追踪路径。
- `yadm alt` 通常自动运行；需要恢复软链、切换 class 后重建或应用相关 hook 时，也可按任务需要手工运行。
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
| Commit | `yadm commit -m "msg"` |
| Push/pull | `yadm push` / `yadm pull` |
| Encrypt/decrypt secrets | `yadm encrypt` / `yadm decrypt [-l]` |
| Re-create alt symlinks | `yadm alt` |
| Check if file is tracked | `yadm ls-files \| grep <pattern>` |

## Key Conventions

- 暂存按任务范围使用显式路径；只有用户明确授权时才提交或推送。
- Prefer `yadm add -u` over `yadm add -A` — only stages modified/deleted files, not untracked. Use explicit `yadm add <path>` for new files.
- `yadm status` only shows changed/untracked files. Use `yadm list`/`yadm ls-files` to confirm a file IS tracked.
