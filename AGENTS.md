# Repository Guidelines

## Project Structure & Module Organization
The Neovim entry point is `init.lua`, which loads lazy.nvim setup and shared LSP defaults before declaring keymaps and editor options. Plugin bootstrap and global plugin definitions live in `lua/config/lazy.lua`, while individual plugin specs stay in `lua/config/plugins/` (each file returns a `lazy` spec table). Shared configuration helpers reside under `lua/config/`, and LSP server overrides belong in `lsp/` (for example `lsp/lua_ls.lua`). User autocommands that must be sourced on startup go in `plugin/` (see `plugin/floaterminal.lua`). `lazy-lock.json` pins plugin commits; refresh it only when intentionally upgrading.

## Build, Test, and Development Commands
Use `nvim --headless "+lua require('config.lazy')" +qa` to confirm the lazy bootstrap and Lua modules compile without errors. Run `nvim --headless "+Lazy! sync" +qa` after editing plugin specs to install or clean plugins. During development, reload the current file with `:source %`, and open the health report with `:checkhealth` to catch missing dependencies early.

## Coding Style & Naming Conventions
Indent Lua with two spaces and avoid hard tabs; the repo explicitly sets `tabstop`, `shiftwidth`, and `expandtab` in `init.lua`. Name modules and files in `snake_case` and keep plugin spec tables named after the plugin (e.g., `return { "nvim-treesitter/nvim-treesitter", opts = { ... } }`). Prefer `local` scopes, descriptive option keys, and `vim.keymap.set` with `desc` metadata. When adding keymaps or autocmds, follow the existing pattern of grouping related mappings and providing concise descriptions.

## Testing Guidelines
Before pushing, launch Neovim normally and interact with modified features (keymaps, commands, autocommands). For automated checks, run `nvim --headless "+checkhealth" +qa` and ensure it exits cleanly. When touching LSP settings, verify via `:LspInfo` that the targeted server attaches, and inspect the quickfix list shortcut `<leader>le` to confirm diagnostics surface. Keep tests manual but reproducible; document any prerequisites in the relevant module.

## Commit & Pull Request Guidelines
Commits in this repo use brief, imperative sentences (`remove useless code`, `vim lsp added for lua`). Mirror that style, limit the body to essential context, and update `lazy-lock.json` in the same commit when dependency pins change. Pull requests should summarize the change set, call out new keymaps or user-facing defaults, link related issues, and include screenshots or terminal captures if UI elements (trees, float terminals) change noticeably.
