return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  cmd = {
    "ObsidianNew",
    "ObsidianQuickSwitch",
    "ObsidianToday",
    "ObsidianSearch",
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/note",
      },
    },
    completion = {
      -- Disable nvim-cmp integration since this config uses blink.cmp.
      nvim_cmp = false,
    },
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
    },
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
    ui = {
      enable = false,
    },
  },
  config = function(_, opts)
    opts.completion = opts.completion or {}
    opts.completion.nvim_cmp = false

    if opts.templates and opts.templates.folder then
      local uv = vim.uv or vim.loop
      local function ensure_dir(path)
        local stat = uv.fs_stat(path)
        if stat and stat.type == "directory" then
          return true
        end
        local ok, err = pcall(vim.fn.mkdir, path, "p")
        if not ok then
          vim.notify(
            ("obsidian.nvim: unable to create templates dir '%s': %s. Templates disabled."):format(path, err),
            vim.log.levels.WARN
          )
          return false
        end
        return true
      end

      for _, workspace in ipairs(opts.workspaces or {}) do
        local root = vim.fs.normalize(vim.fn.expand(workspace.path))
        local folder = opts.templates.folder
        local is_absolute = folder:sub(1, 1) == "/" or folder:sub(1, 1) == "~"
        local target = is_absolute and vim.fs.normalize(vim.fn.expand(folder)) or (root .. "/" .. folder)
        if not ensure_dir(target) then
          opts.templates = nil
          break
        end
      end
    end

    require("obsidian").setup(opts)
  end,
  keys = {
    { "<leader>nn", "<cmd>ObsidianNew<CR>",         desc = "New Obsidian note" },
    { "<leader>no", "<cmd>ObsidianQuickSwitch<CR>", desc = "Switch Obsidian note" },
    { "<leader>nd", "<cmd>ObsidianToday<CR>",       desc = "Today note" },
    { "<leader>ns", "<cmd>ObsidianSearch<CR>",      desc = "Search Obsidian vault" },
  },
}
