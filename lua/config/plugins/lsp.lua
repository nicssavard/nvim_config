return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      -- Retrieve LSP capabilities from blink.cmp
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      ----------------------------------------------------------------------------
      -- 1) Lua LS
      ----------------------------------------------------------------------------
      require("lspconfig").lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      }

      ----------------------------------------------------------------------------
      -- 2) C/C++ LS
      ----------------------------------------------------------------------------
      require("lspconfig").clangd.setup {
        capabilities = capabilities,
        cmd = { "clangd", "--background-index" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            '.clangd',
            '.clang-tidy',
            '.clang-format',
            'compile_commands.json',
            'compile_flags.txt',
            'configure.ac',
            '.git'
          )(fname) or vim.fn.getcwd()
        end,
        single_file_support = true,
      }

      ----------------------------------------------------------------------------
      -- 3) TypeScript LS
      ----------------------------------------------------------------------------
      require("lspconfig").ts_ls.setup {
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            'tsconfig.json',
            'package.json',
            'jsconfig.json',
            '.git'
          )(fname) or vim.fn.getcwd()
        end,
      }

      ----------------------------------------------------------------------------
      -- 4) Elixir LS
      ----------------------------------------------------------------------------
      require("lspconfig").elixirls.setup {
        capabilities = capabilities,
        cmd = { "elixir-ls" },
        filetypes = { "elixir", "eelixir" },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            'mix.exs',
            '.git'
          )(fname) or vim.fn.getcwd()
        end,
      }


      ----------------------------------------------------------------------------
      -- 4) Java
      ----------------------------------------------------------------------------
      require("lspconfig").jdtls.setup {
        capabilities = capabilities,
        cmd = { "jdtls" },
        root_dir = function(fname)
          return require('lspconfig.util').root_pattern(
            '.project',
            '.git',
            'pom.xml',
            'build.gradle'
          )(fname) or vim.fn.getcwd()
        end,
        filetypes = { "java" },
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            completion = {
              favoriteStaticMembers = {
                "org.assertj.core.api.Assertions.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*"
              },
            },
          },
        },
      }
      ----------------------------------------------------------------------------
      -- Keybindings & auto-format on save
      ----------------------------------------------------------------------------
      local function set_lsp_keymaps(bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set

        keymap('n', '<leader>lr', vim.lsp.buf.rename, opts)
        keymap('n', 'gd', vim.lsp.buf.definition, opts)
        keymap('n', 'K', vim.lsp.buf.hover, opts)
        keymap('n', 'gr', vim.lsp.buf.references, opts)
        keymap('n', 'gD', vim.lsp.buf.declaration, opts)
        keymap('n', 'gi', vim.lsp.buf.implementation, opts)
        keymap('n', '<leader>la', vim.lsp.buf.code_action, opts)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          -- Set up the keymaps
          set_lsp_keymaps(args.buf)

          -- Auto-format on save
          -- vim.api.nvim_create_autocmd('BufWritePre', {
          --   buffer = args.buf,
          --   callback = function()
          --     vim.lsp.buf.format({ bufnr = args.buf, async = false })
          --   end,
          -- })
        end,
      })
    end,
  }
}
-- -- lua/config/plugins.lua
-- return {
-- 	-- Completion Framework
-- 	{
-- 		"hrsh7th/nvim-cmp",
-- 		dependencies = {
-- 		        "hrsh7th/cmp-nvim-lsp",
-- 			"hrsh7th/cmp-buffer",
-- 			"hrsh7th/cmp-path",
-- 			"hrsh7th/cmp-nvim-lua",
-- 			"saadparwaiz1/cmp_luasnip",
-- 			"L3MON4D3/LuaSnip",
-- 			"rafamadriz/friendly-snippets",
-- 			"hrsh7th/cmp-cmdline", -- Ensure this is included
-- 		},
-- 		config = function()
-- 			local cmp = require('cmp')
-- 			local luasnip = require('luasnip')
--
-- 			-- Load friendly snippets
-- 			require("luasnip.loaders.from_vscode").lazy_load()
--
-- 			cmp.setup({
-- 				snippet = {
-- 					expand = function(args)
-- 						luasnip.lsp_expand(args.body)
-- 					end,
-- 				},
-- 				mapping = cmp.mapping.preset.insert({
-- 					['<C-s>'] = cmp.mapping.complete(),
-- 					['<CR>'] = cmp.mapping.confirm({ select = true }),
-- 					['<Tab>'] = cmp.mapping(function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_next_item()
-- 						elseif luasnip.expandable() then
-- 							luasnip.expand()
-- 						elseif luasnip.expand_or_jumpable() then
-- 							luasnip.expand_or_jump()
-- 						else
-- 							fallback()
-- 						end
-- 					end, { 'i', 's' }),
-- 					['<S-Tab>'] = cmp.mapping(function(fallback)
-- 						if cmp.visible() then
-- 							cmp.select_prev_item()
-- 						elseif luasnip.jumpable(-1) then
-- 							luasnip.jump(-1)
-- 						else
-- 							fallback()
-- 						end
-- 					end, { 'i', 's' }),
-- 				}),
-- 				sources = cmp.config.sources({
-- 					{ name = 'nvim_lsp' },
-- 					{ name = 'luasnip' },
-- 				}, {
-- 					{ name = 'buffer' },
-- 					{ name = 'path' },
-- 				}),
-- 			})
--
-- 			-- Setup cmdline completion for '/'
-- 			cmp.setup.cmdline('/', {
-- 				mapping = cmp.mapping.preset.cmdline(),
-- 				sources = {
-- 					{ name = 'buffer' }
-- 				}
-- 			})
--
-- 			-- Setup cmdline completion for ':'
-- 			cmp.setup.cmdline(':', {
-- 				mapping = cmp.mapping.preset.cmdline(),
-- 				sources = cmp.config.sources({
-- 					{ name = 'path' }
-- 				}, {
-- 					{ name = 'cmdline' }
-- 				})
-- 			})
-- 		end
-- 	},
--
-- 	-- Mason for managing LSP servers
-- 	{
-- 		"williamboman/mason.nvim",
-- 		build = ":MasonUpdate",
-- 		config = function()
-- 			require("mason").setup()
-- 		end
-- 	},
-- 	{
-- 		"williamboman/mason-lspconfig.nvim",
-- 		dependencies = {
-- 			"williamboman/mason.nvim",
-- 			"neovim/nvim-lspconfig",
-- 		},
-- 		config = function()
-- 			require("mason-lspconfig").setup({
-- 				ensure_installed = { "ts_ls", "lua_ls" }, -- Ensure correct LSP server names
-- 				-- ensure_installed = {  "lua_ls" }, -- Ensure correct LSP server names
-- 			})
-- 		end
-- 	},
--
-- 	-- LSP Configuration
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		dependencies = { "williamboman/mason-lspconfig.nvim" },
-- 		config = function()
-- 			local lspconfig = require("lspconfig")
-- 			local cmp_lsp = require("cmp_nvim_lsp")
--
-- 			-- Enhanced capabilities for nvim-cmp
-- 			local capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
--
-- 			-- Common on_attach function without formatting
-- 			local on_attach = function(client, bufnr)
-- 				-- Disable formatting for tsserver to let null-ls handle it
-- 				if client.name == "ts_ls" then
-- 					client.server_capabilities.document_formatting = false
-- 					client.server_capabilities.document_range_formatting = false
-- 				end
--
-- 				-- Enable completion triggered by <c-x><c-o>
-- 				vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--
-- 				-- Keybindings
-- 				local opts = { noremap = true, silent = true }
-- 				local buf_set_keymap = vim.api.nvim_buf_set_keymap
-- 				buf_set_keymap(bufnr, 'n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
-- 				buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- 				buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
-- 				buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
-- 				buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
-- 				buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- 				buf_set_keymap(bufnr, 'n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--
-- 				-- Remove auto-formatting on save
-- 				-- The formatting is handled by null-ls.nvim
-- 			end
--
-- 			-- Setup LSP servers
-- 			local servers = { "ts_ls", "lua_ls" }
--
-- 			for _, server in ipairs(servers) do
-- 				lspconfig[server].setup({
-- 					on_attach = on_attach,
-- 					capabilities = capabilities,
-- 					settings = server == "lua_ls" and {
-- 						Lua = {
-- 							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
-- 							telemetry = { enable = false },
-- 						},
-- 					} or {},
-- 				})
-- 			end
-- 		end
-- 	},
-- }
