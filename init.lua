require("config.lazy")

-- Keymaps
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
vim.opt.clipboard = "unnamedplus"

-- LSP Keymaps
vim.keymap.set("n", "grn", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set("n", "grr", vim.lsp.buf.references, { desc = "References" })
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show Diagnostics" })

-- Splits
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { noremap = true, silent = true, desc = "Vertical Split" })
vim.keymap.set("n", "<leader>\\", ":split<CR>", { noremap = true, silent = true, desc = "Horizontal Split" })

-- Tmux Navigation
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate Left" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate Right" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate Down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate Up" })

-- Neovim Window Resizing with Ctrl + Arrow
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })


-- Move throught the quick list
vim.keymap.set("n", "<leader>]", "<cmd>cnext<CR>")
vim.keymap.set("n", "<leader>[", "<cmd>cprev<CR>")

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Highlight Yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local function set_qf_list()
  vim.diagnostic.setqflist()      -- Populate quickfix list with diagnostics
  vim.cmd('copen 15')            -- Open quickfix window with height 15
end

-- 3. Create keymap for normal mode: <leader>e
vim.keymap.set('n', '<leader>le', set_qf_list, { desc = 'LSP Diagnostics in Quickfix' })


vim.opt.autoindent = true    -- Copy indentation from the previous line
vim.opt.smartindent = true   -- Add extra indent for new lines in code blocks
vim.opt.tabstop = 2          -- Number of spaces for a tab
vim.opt.shiftwidth = 2       -- Number of spaces for auto-indent
vim.opt.softtabstop = 2      -- Number of spaces to use for <Tab>
vim.opt.expandtab = true     -- Use spaces instead of tabs

        vim.api.nvim_set_keymap("n", "<leader>o", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
-- Enable absolute line numbers
vim.opt.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true

-- Lua configuration (e.g., in init.lua or a separate config file)

-- Function to check if there are no open buffers other than the default
local function is_empty_start()
	return #vim.api.nvim_list_bufs() == 1 and vim.fn.empty(vim.fn.expand('%:t')) == 1
end

-- Function to set up the custom start screen
local function setup_start_screen()
	if is_empty_start() then
		-- Create a new buffer
		vim.api.nvim_command('enew')
		-- Set buffer options
		vim.api.nvim_buf_set_option(0, 'buftype', 'nofile')
		vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')
		vim.api.nvim_buf_set_option(0, 'swapfile', false)
		-- Define your custom message
		local welcome_message = {
			"Welcome!",
		}
		-- Set the buffer content
		vim.api.nvim_buf_set_lines(0, 0, -1, false, welcome_message)
		-- Center the window vertically
		vim.cmd('normal! zz')
		-- Make the buffer non-modifiable
		vim.api.nvim_buf_set_option(0, 'modifiable', false)
	end
end

-- Create an autocommand for VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
	callback = setup_start_screen,
})
