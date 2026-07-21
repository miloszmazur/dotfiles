local ts = require('nvim-treesitter')

local ensure_installed = {
  "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript",
  "markdown", "markdown_inline",
}
ts.install(ensure_installed)

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match) or args.match
    if vim.list_contains(ts.get_installed('parsers'), lang) then
      pcall(vim.treesitter.start, args.buf, lang)
    else
      ts.install(lang):await(function()
        pcall(vim.treesitter.start, args.buf, lang)
      end)
    end
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
    include_surrounding_whitespace = false,
  },
  move = { set_jumps = true },
}

local select = require("nvim-treesitter-textobjects.select")
local sel = {
  ["af"] = "@function.outer",    ["if"] = "@function.inner",
  ["ac"] = "@conditional.outer", ["ic"] = "@conditional.inner",
  ["is"] = "@assignment.inner",  ["as"] = "@assignment.lhs",
  ["aC"] = "@class.outer",       ["iC"] = "@class.inner",
  ["al"] = "@block.outer",       ["il"] = "@block.inner",
  ["aa"] = "@call.outer",        ["ia"] = "@call.inner",
}
for lhs, obj in pairs(sel) do
  vim.keymap.set({ "x", "o" }, lhs, function()
    select.select_textobject(obj, "textobjects")
  end)
end

local swap = require("nvim-treesitter-textobjects.swap")
vim.keymap.set("n", "<leader>a", function() swap.swap_next("@parameter.inner") end)
vim.keymap.set("n", "<leader>A", function() swap.swap_previous("@parameter.inner") end)
