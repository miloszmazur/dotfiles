local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('ruff', { capabilities = capabilities })
vim.lsp.config('marksman', { capabilities = capabilities })
vim.lsp.config('rust_analyzer', { capabilities = capabilities })
vim.lsp.config('taplo', { capabilities = capabilities })
vim.lsp.config('pyright', { capabilities = capabilities })
vim.lsp.config('ts_ls', { capabilities = capabilities })

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
vim.lsp.enable({
  'lua_ls',
  'ruff',
  'marksman',
  'pylsp',
  'rust_analyzer',
  'taplo',
  'helm_ls',
  'pyright',
  'ts_ls'
})

vim.diagnostic.config({ float = { source = 'if_many' }, virtual_text = true })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
