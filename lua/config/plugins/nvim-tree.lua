return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function set_highlights()
      vim.api.nvim_set_hl(0, 'NvimTreeModifiedIcon', { fg = '#fbbf24' })
      vim.api.nvim_set_hl(0, 'NvimTreeGitNew', { fg = '#34d399' })
      vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { fg = '#f97316' })
    end

    set_highlights()
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = set_highlights,
    })

    require("nvim-tree").setup {
      filters = {
        dotfiles = false, -- Show dotfiles
        -- You can add more filter options here if needed
      },
      -- Enable showing of git-ignored files
      git = {
        enable = true,
        ignore = false, -- Show git-ignored files
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      update_focused_file = {
        enable = true,
        update_root = true,
      },
      renderer = {
        highlight_git = true,
        highlight_modified = "name",
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = true,
            modified = true,
          },
          -- glyphs = {
          --   modified = "●",
          -- },
        },
        indent_markers = {
          enable = false,
        },
      },
      on_attach = function(bufnr)
        local api = require('nvim-tree.api')

        -- Helper function to create keybinding options
        local function opts(desc)
          return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- Keybindings within nvim-tree buffer
        vim.keymap.set('n', '<cr>', api.node.open.edit, opts('Open File or Directory'))
        vim.keymap.set('n', 'l', api.node.open.edit, opts('Open File or Directory'))
        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Parent Directory'))
        vim.keymap.set('n', 'a', api.fs.create, opts('Create File or Directory')) -- Add back create functionality
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete File or Directory'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename File or Directory'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close Tree'))
      end,
    }
  end,
}








-- return {
--     "nvim-tree/nvim-tree.lua",
--     version = "*",
--     lazy = false,
--     dependencies = {
--         "nvim-tree/nvim-web-devicons", -- Optional: Keep for potential future use
--     },
--     config = function()
--         require("nvim-tree").setup({
--             -- Disable icons
--             renderer = {
--                 icons = {
--                     show = {
--                         file = false,
--                         folder = false,
--                         folder_arrow = false,
--                         git = false,
--                     },
--                 },
--                 indent_markers = {
--                     enable = false,
--                 },
--             },
--             -- Define keybindings using on_attach
--             on_attach = function(bufnr)
--                 local api = require('nvim-tree.api')
--
--                 -- Helper function to create keybinding options
--                 local function opts(desc)
--                     return {
--                         desc = 'nvim-tree: ' .. desc,
--                         buffer = bufnr,
--                         noremap = true,
--                         silent = true,
--                         nowait = true
--                     }
--                 end
--
--                 -- Keybindings within nvim-tree buffer
--                 vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
--                 vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
--
--                 -- Optional: Additional keybindings
--                 vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
--                 vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
--                 vim.keymap.set('n', 'q', api.tree.close, opts('Close Tree'))
--             end,
--             -- Other configurations
--             disable_netrw = true,
--             hijack_netrw = true,
--             update_focused_file = {
--                 enable = true,
--                 update_cwd = true,
--                 ignore_list = {},
--             },
--             actions = {
--                 open_file = {
--                     quit_on_open = false,
--                     resize_window = false,
--                     window_picker = {
--                         enable = false,
--                     },
--                 },
--             },
--             view = {
--                 width = 30,
--                 side = "left",
--                 -- auto_resize = false,
--             },
--         })
--
--         -- Global keybinding to toggle nvim-tree
--         vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
--         vim.api.nvim_set_keymap("n", "<leader>o", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
--     end,
-- }
