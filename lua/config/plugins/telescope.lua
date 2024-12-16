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
		--		vim.keymap.set("n", "<space>fw", require('telescope.builtin').live_grep)
		require "config.telescope.multigrep".setup()
	end
}
