# AGENTS.md — Global Instructions for openCode

## Language
- Reply in Chinese unless the user writes in English
- Use Chinese for explanations, comments, and documentation
- Keep code identifiers in English

## Code Style
- Follow existing project conventions
- Let code explain itself; comment only where intent is not obvious
- Keep responses concise
- Use emoji only when requested

## Tool Usage
- Use Read to inspect files, Glob to find paths, and Grep to search content
- Use Edit for targeted changes; use Write for new files or full replacements
- Use absolute paths
- Prefer native tools and CLI (`gh`, `jq`); use MCP when it adds value

## Workflow
- Investigate first: read the relevant files and verify assumptions before acting
- Ask when the request or context is ambiguous
- Read a file before editing it
- Start with read-only checks before changing state
- Make one change at a time for risky work, then report the result
- Validate configuration before applying it
- Run the relevant check after changes and report the command and outcome
- Commit only when explicitly requested
- Use only verified URLs

## Safety
- Keep secrets out of code, logs, and responses
- Confirm destructive or irreversible operations before running them
- Prefer incremental changes over rewrites
