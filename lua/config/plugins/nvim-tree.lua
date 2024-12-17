return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- Optional: Keep for potential future use
    },
    config = function()
        require("nvim-tree").setup({
            -- Disable icons
            renderer = {
                icons = {
                    show = {
                        file = false,
                        folder = false,
                        folder_arrow = false,
                        git = false,
                    },
                },
                indent_markers = {
                    enable = false,
                },
            },
            -- Define keybindings using on_attach
            on_attach = function(bufnr)
                local api = require('nvim-tree.api')

                -- Helper function to create keybinding options
                local function opts(desc)
                    return {
                        desc = 'nvim-tree: ' .. desc,
                        buffer = bufnr,
                        noremap = true,
                        silent = true,
                        nowait = true
                    }
                end

                -- Keybindings within nvim-tree buffer
                vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
                vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))

                -- Optional: Additional keybindings
                vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
                vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
                vim.keymap.set('n', 'q', api.tree.close, opts('Close Tree'))
            end,
            -- Other configurations
            disable_netrw = true,
            hijack_netrw = true,
            update_focused_file = {
                enable = true,
                update_cwd = true,
                ignore_list = {},
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                    resize_window = false,
                    window_picker = {
                        enable = false,
                    },
                },
            },
            view = {
                width = 30,
                side = "left",
                -- auto_resize = false,
            },
        })

        -- Global keybinding to toggle nvim-tree
        vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>o", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
    end,
}
