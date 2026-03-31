vim.loader.enable()

-- CoC language server extensions
vim.g.coc_global_extensions = {
  'coc-pyright',
  'coc-json',
  'coc-yaml',
  'coc-sh',
  'coc-go',
  'coc-html',
  'coc-css',
}

-- GitHub URL helper
local gh = function(repo) return 'https://github.com/' .. repo end

-- Plugin post-install/update hooks
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind

  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  elseif name == 'coc-nginx' and (kind == 'install' or kind == 'update') then
    vim.system({ 'yarn', 'install', '--frozen-lockfile' }, { cwd = ev.data.path })
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
  -- Editing
  gh('vim-scripts/comments.vim'),
  -- Git
  gh('tpope/vim-fugitive'),
  gh('tpope/vim-rhubarb'),
  gh('lewis6991/gitsigns.nvim'),
  -- File explorer
  gh('nvim-tree/nvim-tree.lua'),
  -- UI
  gh('Yggdroot/indentLine'),
  gh('godlygeek/tabular'),
  gh('echasnovski/mini.ai'),
  gh('majutsushi/tagbar'),
  gh('rcarriga/nvim-notify'),
  -- LSP
  { src = gh('neoclide/coc.nvim'), version = 'release' },
  { src = gh('yaegassy/coc-nginx'), name = 'coc-nginx' },
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
vim.opt.undodir = vim.fn.expand('~/.vim/.backup//')

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

-- nvim-tree
vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<C-o>', '<cmd>NvimTreeFindFile<CR>', { silent = true })

vim.opt.background = 'dark'
vim.cmd('colorscheme OceanicNext')

-- OceanicNext configs
vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1

-- CoC floating window colors
vim.api.nvim_set_hl(0, 'CocFloating', { bg = '#1b2b34' })
vim.api.nvim_set_hl(0, 'CocFloatBorder', { fg = '#65737e', bg = '#1b2b34' })

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

-- indentLine settings
vim.g.indentLine_enabled = 1

-- coc configuration

-- Some servers have issues with backup files
vim.opt.backup = false
vim.opt.writebackup = false

-- Give more space for displaying messages
vim.opt.cmdheight = 2

-- Having longer updatetime leads to noticeable delays
vim.opt.updatetime = 300

-- Don't pass messages to |ins-completion-menu|
vim.opt.shortmess:append('c')

-- Always show the signcolumn
vim.opt.signcolumn = 'yes'

-- Helper function for tab completion
local function check_backspace()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use tab for trigger completion with characters ahead and navigate
vim.keymap.set('i', '<TAB>', function()
  if vim.fn['coc#pum#visible']() == 1 then
    return vim.fn['coc#pum#next'](1)
  elseif check_backspace() then
    return vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
  else
    return vim.fn['coc#refresh']()
  end
end, { silent = true, expr = true })

vim.keymap.set('i', '<S-TAB>', function()
  if vim.fn['coc#pum#visible']() == 1 then
    return vim.fn['coc#pum#prev'](1)
  else
    return vim.api.nvim_replace_termcodes('<C-h>', true, true, true)
  end
end, { silent = true, expr = true })

-- Make <CR> to accept selected completion item or notify coc.nvim to format
vim.keymap.set('i', '<CR>', function()
  if vim.fn['coc#pum#visible']() == 1 then
    return vim.fn['coc#pum#confirm']()
  else
    return vim.api.nvim_replace_termcodes('<C-g>u<CR><C-r>=coc#on_enter()<CR>', true, true, true)
  end
end, { silent = true, expr = true })

-- Use <c-space> to trigger completion
vim.keymap.set('i', '<C-space>', function()
  return vim.fn['coc#refresh']()
end, { silent = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics
vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })
vim.keymap.set('n', '<leader>?', ':call CocAction("diagnosticInfo")<CR>', { silent = true })

-- GoTo code navigation
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Use K to show documentation in preview window
vim.keymap.set('n', 'K', function()
  local filetype = vim.bo.filetype
  if filetype == 'vim' or filetype == 'help' then
    vim.cmd('h ' .. vim.fn.expand('<cword>'))
  else
    vim.fn.CocActionAsync('doHover')
  end
end, { silent = true })

-- Highlight the symbol and its references when holding the cursor
vim.api.nvim_create_autocmd('CursorHold', {
  pattern = '*',
  callback = function() vim.fn.CocActionAsync('highlight') end,
})

-- Symbol renaming
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)')

-- Formatting selected code
vim.keymap.set('x', '<leader>f', '<Plug>(coc-format-selected)')
vim.keymap.set('n', '<leader>f', '<Plug>(coc-format-selected)')

-- Setup formatexpr and signature help
local mygroup = vim.api.nvim_create_augroup('mygroup', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = mygroup,
  pattern = { 'typescript', 'json' },
  callback = function() vim.bo.formatexpr = "CocAction('formatSelected')" end,
})
vim.api.nvim_create_autocmd('User', {
  group = mygroup,
  pattern = 'CocJumpPlaceholder',
  callback = function() vim.fn.CocActionAsync('showSignatureHelp') end,
})

-- Applying codeAction to the selected region
vim.keymap.set('x', '<leader>a', '<Plug>(coc-codeaction-selected)')
vim.keymap.set('n', '<leader>a', '<Plug>(coc-codeaction-selected)')

-- Remap keys for applying codeAction to the current buffer
vim.keymap.set('n', '<leader>ac', '<Plug>(coc-codeaction)')
-- Apply AutoFix to problem on the current line
vim.keymap.set('n', '<leader>qf', '<Plug>(coc-fix-current)')

-- Map function and class text objects
vim.keymap.set('x', 'if', '<Plug>(coc-funcobj-i)')
vim.keymap.set('o', 'if', '<Plug>(coc-funcobj-i)')
vim.keymap.set('x', 'af', '<Plug>(coc-funcobj-a)')
vim.keymap.set('o', 'af', '<Plug>(coc-funcobj-a)')
vim.keymap.set('x', 'ic', '<Plug>(coc-classobj-i)')
vim.keymap.set('o', 'ic', '<Plug>(coc-classobj-i)')
vim.keymap.set('x', 'ac', '<Plug>(coc-classobj-a)')
vim.keymap.set('o', 'ac', '<Plug>(coc-classobj-a)')

-- Use CTRL-S for selection ranges
vim.keymap.set('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true })
vim.keymap.set('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true })

-- Add :Format command to format current buffer
vim.api.nvim_create_user_command('Format', function()
  vim.fn.CocAction('format')
end, {})

-- Add :Fold command to fold current buffer
vim.api.nvim_create_user_command('Fold', function(opts)
  vim.fn.CocAction('fold', opts.args)
end, { nargs = '?' })

-- Add :OR command for organize imports
vim.api.nvim_create_user_command('OR', function()
  vim.fn.CocAction('runCommand', 'editor.action.organizeImport')
end, {})

-- Mappings for CoCList
vim.keymap.set('n', '<space>a', ':<C-u>CocList diagnostics<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>e', ':<C-u>CocList extensions<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>c', ':<C-u>CocList commands<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>o', ':<C-u>CocList outline<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>s', ':<C-u>CocList -I symbols<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>j', ':<C-u>CocNext<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>k', ':<C-u>CocPrev<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>p', ':<C-u>CocListResume<CR>', { silent = true, nowait = true })

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
