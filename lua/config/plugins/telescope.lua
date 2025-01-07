return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {
    }

    vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
    vim.keymap.set("n", "<space>ff", require('telescope.builtin').find_files)

    vim.keymap.set("n", "<leader>fn", function()
      require('telescope.builtin').find_files({
        prompt_title = "Notes",
        cwd = "/Users/nicolassavard/note/", -- folder to search in
      })
    end, { desc = "Find files in my notes folder" })

    vim.keymap.set("n", "<leader>fng", function()
      require('telescope.builtin').find_files({
        prompt_title = "Notes",
        cwd = "/Users/nicolassavard/jmap/jmapcloud/jmapcloud-ng/", -- folder to search in
      })
    end, { desc = "Find files in jmapcloud-ng" })

    vim.keymap.set("n", "<leader>fngc", function()
      require('telescope.builtin').find_files({
        prompt_title = "Notes",
        cwd = "/Users/nicolassavard/jmap/jmapcloud/jmapcloud-ng-core/", -- folder to search in
      })
    end, { desc = "Find files in jmapcloud-ng-core" })

    vim.keymap.set("n", "<leader>fp", function()
      require('telescope.builtin').find_files({
        prompt_title = "Notes",
        cwd = "/Users/nicolassavard/jmap/jmapcloud/jmapcloud-frontend/app/jmapcloud-portal/", -- folder to search in
      })
    end, { desc = "Find files in portal" })

    vim.keymap.set("n", "<leader>fs", function()
      require('telescope.builtin').find_files({
        prompt_title = "studio",
        cwd = "/Users/nicolassavard/jmap/jmapcloud/jmapcloud-frontend/app/jmapcloud-studio/", -- folder to search in
      })
    end, { desc = "Find files in studio" })
    --		vim.keymap.set("n", "<space>fw", require('telescope.builtin').live_grep)
    require "config.telescope.multigrep".setup()
  end
}
