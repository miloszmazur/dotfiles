local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>ht', builtin.help_tags, {})
vim.keymap.set('n', '<leader>hk', builtin.keymaps, {})

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
  }
}
