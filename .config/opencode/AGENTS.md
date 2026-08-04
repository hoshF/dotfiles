# AGENTS.md — Global Instructions for openCode

## Language
- Reply in Chinese unless the user writes in English
- Use Chinese for explanations, comments, and documentation
- Code identifiers (variable names, function names) remain in English

## Code Style
- Follow existing project conventions — never impose your own style
- No unnecessary comments — let code explain itself
- No emoji unless the user explicitly requests them
- Keep responses concise — the CLI is not a chat app

## Tool Usage
- Prefer dedicated tools (Read, Write, Edit, Glob, Grep) over bash commands (cat, echo, sed, awk)
- Never use `find` or `ls` for file search — use Glob instead
- Never use `grep` or `rg` for content search — use Grep instead
- Never use `cat`/`head`/`tail` to read files — use Read instead
- Use absolute paths for all file operations

## Workflow
- Think before acting — verify assumptions before writing code
- Read files before editing them — never guess content
- Run verification commands (lint, typecheck, tests) after making changes
- Never commit changes unless the user explicitly asks
- Never guess URLs — only use URLs the user provides or that you've verified

## Safety
- Never expose or log secrets, API keys, or tokens
- Never modify ~/.ssh/, ~/.secrets/, or similar sensitive directories
- Ask before running destructive commands (rm, force push, database drops)
- Prefer incremental changes over rewrites

