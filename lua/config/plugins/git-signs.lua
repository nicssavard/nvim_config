return {
  'lewis6991/gitsigns.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local gitsigns = require('gitsigns')

    gitsigns.setup {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
      },
      numhl = false,  -- Highlight line numbers
      linehl = false, -- Highlight changed lines
      watch_gitdir = {
        interval = 1000,
        follow_files = true
      },
      current_line_blame = false, -- Show Git blame inline
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default status formatter
    }

    vim.keymap.set('n', 'gb', function()
      gitsigns.blame_line { full = true }
    end, { desc = 'Git Blame Line', silent = true })
  end
}
