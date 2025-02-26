# CLAUDE.md - Guidelines for working with this dotfiles repository

## Commands
- `make all` - Run all setup (init, deploy, brew, defaults)
- `make deploy` - Deploy dotfiles and install vim-plug
- `make brew` - Install dependencies from Brewfile
- `make defaults` - Set macOS defaults

## Code Style
- **Commit Format**: Use conventional commits with custom types (see changelog.config.js)
  - Format: `type: emoji description` (max 64 chars)
  - Types: feat, fix, config, chore, docs, refactor, style, perf
- **Indentation**: 2 spaces (no tabs)
- **Line Length**: Prefer wrapping at 80 chars
- **Whitespace**: Auto-remove trailing whitespace on save (except markdown)
- **Shell Scripts**: Use bash with set -e for error handling

## Development Environment
- **Editor**: Neovim with LSP, Treesitter, and Copilot
- **Terminal**: WezTerm with custom keybindings
- **Keyboard**: Dvorak layout support via Karabiner

## AI Guidelines
- Copilot/CopilotChat for code assistance
- Support for English and Japanese in prompts