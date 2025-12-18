return {
  -- Requires elixir-ls on your PATH (e.g., via asdf or mix escript.install).
  cmd = { 'elixir-ls' },

  filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },

  -- Prefer mix projects; fall back to git root.
  root_markers = { 'mix.exs', '.git' },

  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
}
