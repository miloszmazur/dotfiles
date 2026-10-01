return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme kanagawa]])
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-ui-select.nvim' } }
  },
  { 'nvim-tree/nvim-web-devicons',     lazy = true },
  { 'nvim-treesitter/nvim-treesitter', branch = 'main', lazy = false, build = ':TSUpdate' },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'lewis6991/gitsigns.nvim' },
  { 'kylechui/nvim-surround', event = 'VeryLazy' },
  { 'tpope/vim-unimpaired' },
  { 'neovim/nvim-lspconfig' },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' }
    }
  },
  { 'stevearc/conform.nvim' },
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
  { "nvim-treesitter/nvim-treesitter-textobjects", branch = 'main', dependencies = { "nvim-treesitter/nvim-treesitter" } },
}
