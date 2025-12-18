return {
  -- Requires @tailwindcss/language-server on your PATH.
  cmd = { 'tailwindcss-language-server', '--stdio' },

  filetypes = {
    'html',
    'css',
    'scss',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'svelte',
    'vue',
    'heex',
  },

  -- Prefer a Tailwind config file, then fallback to the project package.json or
  -- the repository root.
  root_markers = {
    { 'tailwind.config.js', 'tailwind.config.cjs', 'tailwind.config.ts', 'tailwind.config.mjs' },
    'postcss.config.js',
    'package.json',
    '.git',
  },

  settings = {
    tailwindCSS = {
      includeLanguages = {
        heex = 'html-eex',
      },
    },
  },
}
