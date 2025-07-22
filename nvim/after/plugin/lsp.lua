local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

lspconfig['ruff'].setup { capabilities = capabilities }
lspconfig['marksman'].setup { capabilities = capabilities }
lspconfig['rust_analyzer'].setup { capabilities = capabilities }
lspconfig['taplo'].setup { capabilities = capabilities }
lspconfig['lua_ls'].setup { capabilities = capabilities }

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          'vim',
        },
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
-- to install pylsp plugins run:
-- cd ~/.local/share/nvim/mason/packages/python-lsp-server
-- source venv/bin/activate
-- pip install <package>
vim.lsp.config('pylsp', {
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        autopep8 = {
          enabled = false
        },
        ruff = {
          enabled = false
        },
        pycodestyle = {
          enabled = false
        },
        pyflakes = {
          enabled = false
        },
        mccabe = {
          enabled = false
        }
      }
    }
  }
})
vim.lsp.enable('lua_ls')
vim.lsp.enable('ruff')
vim.lsp.enable('marksman')
vim.lsp.enable('pylsp')
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('taplo')
vim.lsp.enable('helm_ls')
vim.diagnostic.config({ float = { source = 'if_many' }, virtual_text = true })
