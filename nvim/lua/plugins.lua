return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme kanagawa]])
    end
  },
  { 'nvim-telescope/telescope.nvim',          branch = '0.1.x',   dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-ui-select.nvim' },

  { 'nvim-tree/nvim-web-devicons',            lazy = true },
  { 'nvim-treesitter/nvim-treesitter',        build = ':TSUpdate' },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-unimpaired' },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
      { "hrsh7th/cmp-nvim-lua" } }
  },
  { 'christoomey/vim-tmux-navigator' },
  { 'junegunn/vim-slash' },
  {
    'numToStr/Comment.nvim',
    lazy = false,
    config = function()
      require('Comment').setup()
    end
  },
  { 'towolf/vim-helm' },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = { "nvim-treesitter/nvim-treesitter" } },
  {
    "David-Kunz/gen.nvim",
    opts = {
      show_prompt = false, -- Shows the Prompt submitted to Ollama.
      display_mode = "split", -- The display mode. Can be "float" or "split".

    }
  },

}
