# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using lazy.nvim for plugin management and Neovim 0.11+'s native LSP infrastructure (`vim.lsp.enable()`). The configuration supports Lua, TypeScript/JavaScript, Elixir, and Tailwind CSS development with modern completion via blink.cmp.

## Configuration Architecture

The entry point is `init.lua`, which:
1. Loads `lua/config/lazy.lua` - bootstraps lazy.nvim and defines global plugins
2. Loads `lua/config/lsp.lua` - enables LSP servers and sets up shared LSP keybindings
3. Declares editor options, keymaps, and autocommands (format-on-save, highlight yank, etc.)

### Directory Structure

- `lua/config/plugins/` - Individual plugin specifications (each returns a lazy.nvim spec table)
- `lua/config/telescope/` - Custom Telescope utilities (multigrep implementation)
- `lsp/` - LSP server-specific configuration files (lua_ls.lua, ts_ls.lua, etc.)
- `plugin/` - Autoloaded Lua files for custom functionality (floaterminal.lua)

### LSP Configuration (Neovim 0.11+)

This config uses Neovim's modern LSP approach:
- Servers are enabled via `vim.lsp.enable('server_name')` in `lua/config/lsp.lua`
- Server-specific settings live in `lsp/<server_name>.lua` and return a table with `cmd`, `filetypes`, `root_markers`, and `settings`
- The `LspAttach` autocmd in `lua/config/lsp.lua` handles shared keybindings and completion setup

**Active LSP servers:**
- `lua_ls` - Lua (configured in lsp/lua_ls.lua)
- `ts_ls` - TypeScript/JavaScript (configured in lsp/ts_ls.lua)
- `tailwindcss` - Tailwind CSS (configured in lsp/tailwindcss.lua)
- `elixirls` - Elixir (configured in lsp/elixirls.lua)

**Adding a new LSP server:**
1. Add `vim.lsp.enable('server_name')` to `lua/config/lsp.lua`
2. Create `lsp/server_name.lua` returning a config table (see existing files for structure)

### Completion System

Uses `blink.cmp` (lua/config/plugins/completion.lua) with manual trigger mode:
- `<C-Space>` - Manually trigger completion
- `<Tab>` - Select next item (or trigger completion if words before cursor)
- `<S-Tab>` - Select previous item
- `<CR>` - Accept completion
- Native snippet support with `<Tab>`/`<S-Tab>` for snippet navigation

### Key Plugin Specifications

All plugin specs in `lua/config/plugins/` follow lazy.nvim's table structure. The main `lazy.lua` imports them via `{ import = "config.plugins" }`.

## Development Commands

### Neovim Operations

```bash
# Verify configuration compiles without errors
nvim --headless "+lua require('config.lazy')" +qa

# Sync plugins after editing specs (install/update/clean)
nvim --headless "+Lazy! sync" +qa

# Check health and dependencies
nvim --headless "+checkhealth" +qa
```

### Within Neovim

- `:source %` - Reload current Lua file
- `:checkhealth` - Run health checks
- `:LspInfo` - Verify LSP server attachment
- `:Lazy` - Open lazy.nvim plugin manager UI
- `<leader>le` - Populate quickfix list with LSP diagnostics (defined in init.lua:56)

## Code Style

- Indent with 2 spaces (expandtab set in init.lua:64)
- Use `snake_case` for module and file names
- Prefer `vim.keymap.set` with `desc` metadata over `vim.api.nvim_set_keymap`
- Use `local` scopes for all variables
- Format Lua, Python, Go, Java, Rust, C/C++, and Elixir files on save (init.lua:112-124)
- TypeScript/JavaScript excluded from auto-format to avoid blocking on LSP

## Important Keybindings

### LSP (defined in lua/config/lsp.lua and init.lua)
- `gd` - Go to definition
- `grn` - Rename symbol
- `gra` / `<leader>la` - Code action
- `grr` - Show references
- `gl` - Show diagnostics float
- `<leader>le` - LSP diagnostics in quickfix list
- `<leader>f` - Format buffer (async)

### Navigation
- `<C-h/j/k/l>` - Tmux/window navigation
- `<C-Up/Down/Left/Right>` - Resize windows
- `<leader>|` - Vertical split
- `<leader>\\` - Horizontal split

### Telescope (lua/config/plugins/telescope.lua)
- `<space>ff` - Find files
- `<space>fh` - Help tags
- `<leader>fw` - Live multigrep (search_term file_pattern)
- `<leader>fn` - Find in notes folder
- `<leader>fng`, `<leader>fngc`, `<leader>fp`, `<leader>fs` - Project-specific file search

### File Management
- `<leader>e` - Toggle NvimTree
- `<leader>o` - Focus NvimTree
- `<leader>tt` - Toggle floating terminal

### Editing
- `jj` - Exit insert mode
- `<C-s>` - Save file
- `<leader>q` - Quit
- `<leader>/` - Toggle line comment
- `<leader>bc` - Toggle block comment
- `<leader>p` - Paste without yanking (visual mode)
- `<leader>d` - Delete to black hole register

## Commit Style

Follow the existing brief, imperative style:
- `add elixir support`
- `improved suggestions`
- `add oil and git blame`

Include changes to `lazy-lock.json` in the same commit when dependency pins change.
