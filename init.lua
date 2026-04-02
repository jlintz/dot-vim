vim.loader.enable()

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

-- line numbers
vim.opt.number = true

vim.opt.showmatch = true       -- set show matching parenthesis
vim.opt.ignorecase = true      -- ignore case when searching
vim.opt.smartcase = true       -- ignore case if search pattern is all lowercase, case-sensitive otherwise
vim.opt.relativenumber = true  -- relative line numbers

vim.opt.undolevels = 1000
vim.opt.undodir = vim.fn.expand('~/.config/nvim/backup/')

vim.opt.wildignore = { '*.swp', '*.bak', '*.pyc', '*.class' }

vim.opt.title = true

-- enable folding on indents
vim.opt.foldmethod = 'indent'
-- don't autofold anything by default
vim.opt.foldlevel = 100

-- none of these are word dividers
vim.opt.iskeyword:append({ '_', '$', '@', '%', '#' })

-- highlight current line
vim.opt.cursorline = true

-- run python code
vim.keymap.set('', '<F5>', ':!python %<CR>')

-- sane tabstops
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

-- change leader key from \ to ,
vim.g.mapleader = ','

-- fzf-lua
vim.keymap.set('n', '<C-P>', '<cmd>FzfLua files<CR>')

-- toggle comments with Ctrl-c (uses built-in gc)
vim.keymap.set('n', '<C-c>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-c>', 'gc', { remap = true })

-- nvim-tree
vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<C-o>', '<cmd>NvimTreeFindFile<CR>', { silent = true })

vim.opt.background = 'dark'
vim.cmd('colorscheme OceanicNext')

-- OceanicNext configs
vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1

-- LSP floating window colors
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1b2b34' })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#65737e', bg = '#1b2b34' })


-- so that some mapping still works when the cursor is at the end of file
vim.opt.virtualedit = 'onemore'

-- Show trailing whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'red' })
vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])

-- tagbar
vim.keymap.set('n', '<C-i>', ':TagbarToggle<CR>', { silent = true })

-- lualine settings
require('lualine').setup({
  options = {
    theme = 'OceanicNext',
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  tabline = {
    lualine_a = { { 'buffers', mode = 2 } },
    lualine_z = { 'tabs' },
  },
  extensions = {
      'fzf',
      'nvim-tree',
      'fugitive',
      'quickfix',
  }
})

for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, '<cmd>LualineBuffersJump! ' .. i .. '<CR>')
end
vim.keymap.set('n', '<C-w>j', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<C-w>k', '<cmd>bnext<CR>')

vim.opt.ttimeoutlen = 50

-- highlight cloudformation templates
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.template',
  callback = function() vim.bo.filetype = 'json' end,
})

-- sane tabbing for yaml files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'yaml',
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end,
})


vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'

-- Lua plugin configs
require('gitsigns').setup({
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then vim.cmd.normal({ ']c', bang = true }) else gs.nav_hunk('next') end
    end)
    map('n', '[c', function()
      if vim.wo.diff then vim.cmd.normal({ '[c', bang = true }) else gs.nav_hunk('prev') end
    end)

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
    map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line({ full = true }) end)
    map('n', '<leader>hd', gs.diffthis)

    -- Toggles
    map('n', '<leader>tb', gs.toggle_current_line_blame)

    -- Text object
    map({ 'o', 'x' }, 'ih', gs.select_hunk)
  end,
})

require('fzf-lua').setup({
  fzf_colors = true,
})

require('nvim-tree').setup({
  actions = {
    open_file = { quit_on_open = true },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
  },
  renderer = {
    icons = { show = { git = true, file = true, folder = true } },
  },
})

require('mini.ai').setup()

require('todo-comments').setup()

require('mini.align').setup()

require('ibl').setup({
  indent = { char = '┊' },
})

-- LSP: mason + vim.lsp.config (nvim 0.11+)
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyrefly', 'jsonls', 'yamlls', 'bashls', 'gopls', 'html', 'cssls',
    'ansiblels', 'nginx_language_server',
  },
})

local servers = { 'jsonls', 'yamlls', 'bashls', 'gopls', 'html', 'cssls', 'ansiblels', 'nginx_language_server' }
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end
vim.lsp.enable(servers)

-- LSP keymaps (applied when a server attaches to a buffer)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'gy', vim.lsp.buf.type_definition, 'Go to type definition')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('n', 'gr', vim.lsp.buf.references, 'Go to references')

    map('n', '[g', vim.diagnostic.goto_prev, 'Previous diagnostic')
    map('n', ']g', vim.diagnostic.goto_next, 'Next diagnostic')
    map('n', '<leader>?', vim.diagnostic.open_float, 'Show diagnostic')

    map('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, 'Hover documentation')
    map('i', '<C-k>', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, 'Signature help')

    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')

    map({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, 'Code action')
    map('n', '<leader>ac', vim.lsp.buf.code_action, 'Code action')
    map('n', '<leader>qf', vim.lsp.buf.code_action, 'Quick fix')

    map({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'Format')

    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd('CursorHold', {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- Completion: nvim-cmp
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
  completion = {
    completeopt = 'menu,menuone,noselect',
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
  }),
  window = {
    completion = { border = 'rounded', winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None' },
    documentation = { border = 'rounded', winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None' },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- Diagnostic display
vim.diagnostic.config({
  virtual_text = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '⚠',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  float = { border = 'rounded' },
  update_in_insert = false,
})

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- User commands
vim.api.nvim_create_user_command('Format', function()
  vim.lsp.buf.format({ async = true })
end, {})

vim.api.nvim_create_user_command('OR', function()
  vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
end, {})

-- LSP list mappings (replaces CoCList, uses fzf-lua)
vim.keymap.set('n', '<space>a', '<cmd>FzfLua diagnostics_workspace<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>c', '<cmd>FzfLua lsp_code_actions<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>o', '<cmd>FzfLua lsp_document_symbols<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>s', '<cmd>FzfLua lsp_workspace_symbols<CR>', { silent = true, nowait = true })

require('claude-code').setup()

require('which-key').setup({})

require('gen').setup({
  model = 'qwen2.5-coder:7b',
  display_mode = 'split',
  no_auto_close = true,
  hidden = false,
})

-- nvim-treesitter: install parsers and enable highlighting
local ts_languages = { 'python', 'bash', 'yaml', 'go', 'json', 'lua', 'vim', 'toml', 'hcl', 'puppet' }
require('nvim-treesitter').install(ts_languages)

vim.api.nvim_create_autocmd('FileType', {
  pattern = ts_languages,
  callback = function() vim.treesitter.start() end,
})
