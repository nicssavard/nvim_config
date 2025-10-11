return {
  {
    'saghen/blink.cmp',
    version = 'v0.*',
    dependencies = 'rafamadriz/friendly-snippets',
    opts = function(_, opts)
      local function has_words_before()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local line, col = cursor[1], cursor[2]
        if col == 0 then return false end
        local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1] or ''
        return current_line:sub(col, col):match('%s') == nil
      end

      opts = opts or {}

      opts.appearance = vim.tbl_deep_extend('force', {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      }, opts.appearance or {})

      opts.signature = vim.tbl_deep_extend('force', {
        enabled = true,
        trigger = { enabled = false },
      }, opts.signature or {})

      opts.completion = vim.tbl_deep_extend('force', {
        documentation = { auto_show = false },
        accept = { auto_brackets = { enabled = false } },
        list = { selection = 'manual' },
        trigger = {
          show_on_keyword = false,
          show_on_trigger_character = false,
          show_on_accept_on_trigger_character = false,
          show_on_insert_on_trigger_character = false,
        },
      }, opts.completion or {})

      opts.keymap = {
        preset = 'none',
        ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<D-Space>'] = {
          function(cmp)
            cmp.show()
            return true
          end,
        },
        ['<Up>'] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_prev()
              return true
            end
          end,
          'fallback',
        },
        ['<Down>'] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_next()
              return true
            end
          end,
          'fallback',
        },
        ['<Tab>'] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_next()
              return true
            end
          end,
          function(cmp)
            if cmp.snippet_active({ direction = 1 }) then return cmp.snippet_forward() end
          end,
          function()
            if has_words_before() then
              require('blink.cmp').show()
              return true
            end
          end,
          'fallback',
        },
        ['<S-Tab>'] = {
          function(cmp)
            if cmp.is_visible() then
              cmp.select_prev()
              return true
            end
          end,
          function(cmp)
            if cmp.snippet_active({ direction = -1 }) then return cmp.snippet_backward() end
          end,
          'fallback',
        },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-e>'] = { 'cancel', 'fallback' },
      }

      return opts
    end,
  },
}
