local lsp = require('lsp-zero').preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls'
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  vim.keymap.set({ 'n', 'x' }, '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

-- to install pylsp plugins run:
-- cd ~/.local/share/nvim/mason/packages/python-lsp-server
-- source venv/bin/activate
-- pip install <package>
require('lspconfig').pylsp.setup({
  setings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          maxLineLength = 100,
        },
        black = { enabled = true, },
        rope_autoimport = {
          enabled = true
        }
      }
    }
  }
})

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cpm_tabnine' },
  }
})
