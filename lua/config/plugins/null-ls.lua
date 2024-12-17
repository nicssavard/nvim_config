-- lua/config/plugins/null-ls.lua
return {
	'jose-elias-alvarez/null-ls.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local null_ls = require("null-ls")

		-- Define Prettier formatting with custom configuration
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettier.with({
					-- Specify extra arguments to match your Prettier configuration
					extra_args = {
						"--print-width", "200",
						"--no-semi",
						"--quote-props", "consistent",
						"--bracket-same-line", "false",
						"--trailing-comma", "none",
						"--tab-width", "2",
						"--arrow-parens", "avoid",
						"--bracket-spacing", "true",
					},
				}),
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					-- Create an autocommand group for formatting
					vim.api.nvim_create_augroup("Format", { clear = true })

					-- Format the buffer before saving
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = "Format",
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								filter = function(format_client)
									return format_client.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})
	end,
}