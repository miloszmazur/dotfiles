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
    branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-ui-select.nvim' } }
  },
  { 'nvim-tree/nvim-web-devicons',     lazy = true },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'mbbill/undotree' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-unimpaired' },
  { 'neovim/nvim-lspconfig' },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  { 'williamboman/mason-lspconfig.nvim' },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' }
    }
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
}
