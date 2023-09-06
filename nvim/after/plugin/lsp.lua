local lsp = require('lsp-zero').preset("recommended")

lsp.ensure_installed({
	'tsserver',
	'pyright',
	'eslint',
	'lua_ls'
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  },
  sources = {
	  {name = 'nvim_lsp'},
	  {name = 'buffer'},
	  {name = 'path'},
	  {name = 'cpm_tabnine'},
  }
})
