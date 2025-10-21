-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "rose-pine/neovim",
      name = "rose-pine",
      config = function()
        vim.cmd("colorscheme rose-pine")
      end
    },
    {
      "christoomey/vim-tmux-navigator",
      lazy = false,
    },
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true, -- Default setup
    },
    {
      'windwp/nvim-ts-autotag', -- For auto-closing tags
      event = "InsertEnter",
      opts = {},                -- Use default options
    },
    {
      'szw/vim-maximizer',
      keys = {
        { '<leader>bz', ':MaximizerToggle<CR>', desc = 'Zoom/Unzoom window' },
      },
    },
    -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
    {
      "numToStr/Comment.nvim",
      opts = {
        toggler = {
          line = '<leader>/',
          block = '<leader>bc',
        },
        opleader = {
          line = '<leader>/',
          block = '<leader>b',
        }, -- add any options here
      },
    },
    -- import your plugins
    { import = "config.plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  --install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
  -- checker = { enabled = true },
})
