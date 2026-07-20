require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    }
  },
  indent = {
    enable = true
  }
}

require 'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["is"] = "@assignment.inner",
        ["as"] = "@assignment.lhs",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["al"] = "@block.outer",
        ["il"] = "@block.inner",
        ["aa"] = "@call.outer",
        ["ia"] = "@call.inner",
      },
      include_surrounding_whitespace = false,
    },
  },
  swap = {
    enable = true,
    swap_next = {
      ["<leader>a"] = "@parameter.inner",
    },
    swap_previous = {
      ["<leader>A"] = "@parameter.inner",
    },
  },
}

-- Fix markdown highlighting crash on Nvim 0.12 with nvim-treesitter's frozen
-- `master` branch. The plugin's `set-lang-from-info-string!` directive handler
-- assumes a query capture is a single TSNode, but Nvim 0.12 changed captures to
-- a list of nodes. The old handler passes that list to get_node_text(), which
-- calls node:range() on a nil value and crashes the highlighter. Re-register the
-- directive with a 0.12-safe handler (loads after the plugin, so it wins).
-- Remove once migrated to the nvim-treesitter `main` branch.
local query = vim.treesitter.query
query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
  local node = match[pred[2]]
  -- Nvim 0.12: a capture maps to a list of nodes; older Nvim gave a single node.
  if type(node) == "table" then node = node[1] end
  if not node then return end
  local alias = vim.treesitter.get_node_text(node, bufnr)
  local lang = vim.filetype.match { filename = "a." .. alias }
  metadata["injection.language"] = lang or alias
end, { force = true, all = false })

