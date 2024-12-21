-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
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
			"bluz71/vim-moonfly-colors",
			name = "moonfly",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd.colorscheme("moonfly")
			end,
		},
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
    opts = {}, -- Use default options
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
        },			-- add any options here
			},
		},
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			-- event = "InsertEnter",
			config = function()
				require("copilot").setup({
					panel = {
						enabled = true,
						auto_refresh = false,
						keymap = {
							jump_prev = "[[",
							jump_next = "]]",
							accept = "<CR>",
							refresh = "gr",
							open = "<M-CR>",
						},
						layout = {
							position = "bottom", -- | top | left | right
							ratio = 0.4,
						},
					},
					suggestion = {
						enabled = true,
						auto_trigger = true,
						debounce = 75,
						keymap = {
							accept = "<C-l>",
							accept_word = false,
							accept_line = false,
							next = "<M-]>",
							prev = "<M-[>",
							dismiss = "<C-]>",
						},
					},
					filetypes = {
						yaml = false,
						markdown = false,
						help = false,
						gitcommit = false,
						gitrebase = false,
						hgcommit = false,
						svn = false,
						cvs = false,
						["."] = false,
					},
					copilot_node_command = "node", -- Node.js version must be > 16.x
					server_opts_overrides = {},
				})
			end,
		},
		-- import your plugins
		{ import = "config.plugins" },
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	--install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
