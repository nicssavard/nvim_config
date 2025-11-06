return {
  -- Server command; requires `npm install -g typescript typescript-language-server`.
  cmd = { 'typescript-language-server', '--stdio' },

  -- Attach to both JavaScript and TypeScript buffers.
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },

  -- Prefer project roots that contain TypeScript metadata files.
  root_markers = {
    { 'tsconfig.json', 'tsconfig.base.json', 'jsconfig.json', 'package.json' },
    '.git',
  },

  -- Server-specific configuration documented at
  -- https://github.com/typescript-language-server/typescript-language-server#configuration-options
  -- Heavy features such as auto-inserting function calls or inlay hints are left
  -- off to keep the language server responsive. Re-enable them here if needed.
}
