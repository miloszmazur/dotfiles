vim.keymap.set("n", "<leader>v", vim.cmd.vnew)
vim.keymap.set("n", "<leader>dt", function() vim.api.nvim_put({ os.date('%a %b %d %Y') }, 'c', true, true) end)
vim.keymap.set("n", "<c-w>]", ":vert winc ]<cr>")
