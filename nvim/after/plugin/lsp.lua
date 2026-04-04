vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.enable({
  'lua_ls',
  'ruff',
  'marksman',
  'rust_analyzer',
  'taplo',
  'helm_ls',
  'pyright',
  'ts_ls',
})

vim.diagnostic.config({ float = { source = 'if_many' }, virtual_text = true })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
