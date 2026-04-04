local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>ht', builtin.help_tags, {})
vim.keymap.set('n', '<leader>hk', builtin.keymaps, {})
vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>S', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>*', builtin.grep_string, {})
vim.keymap.set('n', '<leader>gl', builtin.git_commits, {})
vim.keymap.set('n', '<leader>gfl', builtin.git_bcommits, {})

require('telescope').setup {
  pickers = {
    find_files = {
      hidden = true,
      find_command = {
        "fd",
        ".",
        "--type",
        "file",
        "--hidden",
        "--strip-cwd-prefix",
        "--exclude", ".git/"
      },
    }
  },
}
require("telescope").load_extension("ui-select")
