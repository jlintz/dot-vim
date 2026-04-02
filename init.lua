vim.loader.enable()

-- Set leader key before any plugin configs
vim.g.mapleader = ','

-- GitHub URL helper
local gh = function(repo) return 'https://github.com/' .. repo end

-- Plugin post-install/update hooks
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind

  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

-- Install and load plugins via built-in vim.pack
vim.pack.add({
  -- Color schemes
  gh('overcache/NeoSolarized'),
  gh('mhartington/oceanic-next'),
  gh('sainnhe/everforest'),
  -- AI
  gh('nvim-lua/plenary.nvim'),
  gh('greggh/claude-code.nvim'),
  gh('David-Kunz/gen.nvim'),
  -- Fuzzy finder
  gh('ibhagwan/fzf-lua'),
  -- Syntax
  gh('nvim-treesitter/nvim-treesitter'),
  -- Status line
  gh('nvim-lualine/lualine.nvim'),
  -- Git
  gh('tpope/vim-fugitive'),
  gh('tpope/vim-rhubarb'),
  gh('lewis6991/gitsigns.nvim'),
  -- File explorer
  gh('nvim-tree/nvim-tree.lua'),
  -- UI
  gh('lukas-reineke/indent-blankline.nvim'),
  gh('echasnovski/mini.align'),
  gh('echasnovski/mini.ai'),
  gh('majutsushi/tagbar'),
  gh('rcarriga/nvim-notify'),
  gh('folke/todo-comments.nvim'),
  -- LSP
  gh('williamboman/mason.nvim'),
  gh('williamboman/mason-lspconfig.nvim'),
  gh('neovim/nvim-lspconfig'),
  -- Completion
  gh('hrsh7th/nvim-cmp'),
  gh('hrsh7th/cmp-nvim-lsp'),
  gh('hrsh7th/cmp-nvim-lsp-signature-help'),
  gh('hrsh7th/cmp-buffer'),
  gh('hrsh7th/cmp-path'),
  gh('L3MON4D3/LuaSnip'),
  gh('saadparwaiz1/cmp_luasnip'),
  -- Misc
  gh('folke/which-key.nvim'),
  gh('christoomey/vim-tmux-navigator'),
  gh('nvim-tree/nvim-web-devicons'),
}, { confirm = false })

-- Core config
require('config.options')
require('config.keymaps')
require('config.autocmds')

-- Plugin configs
require('plugins.colorscheme')
require('plugins.lualine')
require('plugins.gitsigns')
require('plugins.fzf-lua')
require('plugins.nvim-tree')
require('plugins.lsp')
require('plugins.cmp')
require('plugins.treesitter')
require('plugins.mini')
require('plugins.ibl')
require('plugins.todo-comments')
require('plugins.which-key')
require('plugins.claude-code')
require('plugins.gen')
