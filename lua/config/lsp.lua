-- lsp
--------------------------------------------------------------------------------
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.
vim.lsp.enable('lua_ls')
vim.lsp.enable('ts_ls')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not (client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion)) then
      return
    end

    -- Completion behavior
    vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
    vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })

    -- Helper: is there a non-space char before the cursor?
    local function has_words_before()
      local col = vim.api.nvim_win_get_cursor(0)[2]
      if col == 0 then return false end
      local line = vim.api.nvim_get_current_line()
      -- previous byte index is `col` (0-based cursor -> 1-based Lua index)
      return not line:sub(col, col):match("%s")
    end

    -- Manual trigger
    vim.keymap.set('i', '<C-Space>', function()
      vim.lsp.completion.get()
    end, { buffer = ev.buf })

    -- Context-aware <Tab>
    vim.keymap.set('i', '<Tab>', function()
      -- 1) If popup menu is visible, select next item
      if vim.fn.pumvisible() == 1 then
        return '<C-n>'
      end
      -- 2) If we can jump forward in a native snippet, do that
      if vim.snippet and vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
        return ''
      end
      -- 3) If there's a word before, trigger completion
      if has_words_before() then
        vim.lsp.completion.get()
        return ''
      end
      -- 4) Fallback to normal Tab (insert/indent)
      return '<Tab>'
    end, { buffer = ev.buf, expr = true })

    -- Context-aware <S-Tab>
    vim.keymap.set('i', '<S-Tab>', function()
      -- If popup menu is visible, select previous item
      if vim.fn.pumvisible() == 1 then
        return '<C-p>'
      end
      -- Jump backward in snippet if possible
      if vim.snippet and vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
        return ''
      end
      -- Otherwise, fallback (often unindent depending on your settings)
      return '<S-Tab>'
    end, { buffer = ev.buf, expr = true })
  end,
})

-- Diagnostics
vim.diagnostic.config({
  -- virtual_lines = {
  --   current_line = false,
  -- },
})
