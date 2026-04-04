require('conform').setup({
  formatters_by_ft = {
    python = { 'ruff_format' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescriptreact = { 'prettier' },
    lua = { 'stylua' },
    toml = { 'taplo' },
    markdown = { 'prettier' },
  },
})

vim.keymap.set('n', '<leader>f', function()
  require('conform').format({ lsp_format = 'fallback' })
end)
