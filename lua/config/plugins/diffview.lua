return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('diffview').setup {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        merge_tool = {
          layout = "diff3_horizontal",
        },
      },
    }

    -- Open diffview comparing current branch to master
    vim.keymap.set('n', '<leader>gd', ':DiffviewOpen master...HEAD<CR>', { desc = 'Git Diff vs Master', silent = true })

    -- Open file history for current file
    vim.keymap.set('n', '<leader>gh', ':DiffviewFileHistory %<CR>', { desc = 'Git File History', silent = true })

    -- Open file history for entire project
    vim.keymap.set('n', '<leader>gH', ':DiffviewFileHistory<CR>', { desc = 'Git Project History', silent = true })

    -- Close diffview
    vim.keymap.set('n', '<leader>gc', ':DiffviewClose<CR>', { desc = 'Close Git Diff', silent = true })
  end
}
