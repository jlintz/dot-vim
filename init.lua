-- enable 24-bit color
vim.opt.termguicolors = true

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
vim.api.nvim_create_autocmd('User', {
  pattern = 'PackChanged',
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'fzf' then
      vim.fn['fzf#install']()
    elseif name == 'nvim-treesitter' then
      vim.cmd('TSUpdate')
    elseif name == 'coc-nginx' then
      vim.system({ 'yarn', 'install', '--frozen-lockfile' }, { cwd = ev.data.path })
    end
  end,
})

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
  gh('junegunn/fzf'),
  gh('junegunn/fzf.vim'),
  -- Syntax
  gh('nvim-treesitter/nvim-treesitter'),
  -- Status line
  gh('vim-airline/vim-airline'),
  gh('vim-airline/vim-airline-themes'),
  -- Editing
  gh('vim-scripts/comments.vim'),
  -- Git
  gh('tpope/vim-fugitive'),
  gh('tpope/vim-rhubarb'),
  gh('airblade/vim-gitgutter'),
  -- File explorer
  gh('preservim/nerdtree'),
  gh('Xuyuanp/nerdtree-git-plugin'),
  -- UI
  gh('Yggdroot/indentLine'),
  gh('godlygeek/tabular'),
  gh('wellle/targets.vim'),
  gh('majutsushi/tagbar'),
  gh('rcarriga/nvim-notify'),
  -- LSP
  { src = gh('neoclide/coc.nvim'), version = 'release' },
  { src = gh('yaegassy/coc-nginx'), name = 'coc-nginx' },
  -- Misc
  gh('folke/which-key.nvim'),
  gh('christoomey/vim-tmux-navigator'),
  gh('ryanoasis/vim-devicons'),
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

-- fzf
vim.keymap.set('n', '<C-P>', ':Files<CR>')

-- NERDTree options
vim.keymap.set('n', '<C-n>', ':NERDTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<C-o>', ':NERDTreeToggle %<CR>', { silent = true })
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeShowHidden = 1

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
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { ctermbg = 'red', bg = 'red' })
vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])

-- tagbar
vim.keymap.set('n', '<C-i>', ':TagbarToggle<CR>', { silent = true })

-- airline settings
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1
vim.g['airline#extensions#coc#enabled'] = 1
vim.g.airline_theme = 'oceanicnext'

vim.keymap.set('n', '<leader>1', '<Plug>AirlineSelectTab1')
vim.keymap.set('n', '<leader>2', '<Plug>AirlineSelectTab2')
vim.keymap.set('n', '<leader>3', '<Plug>AirlineSelectTab3')
vim.keymap.set('n', '<leader>4', '<Plug>AirlineSelectTab4')
vim.keymap.set('n', '<leader>5', '<Plug>AirlineSelectTab5')
vim.keymap.set('n', '<leader>6', '<Plug>AirlineSelectTab6')
vim.keymap.set('n', '<leader>7', '<Plug>AirlineSelectTab7')
vim.keymap.set('n', '<leader>8', '<Plug>AirlineSelectTab8')
vim.keymap.set('n', '<leader>9', '<Plug>AirlineSelectTab9')
vim.keymap.set('n', '<C-w>j', '<Plug>AirlineSelectPrevTab')
vim.keymap.set('n', '<C-w>k', '<Plug>AirlineSelectNextTab')

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

-- devicons configuration
vim.g.webdevicons_enable_nerdtree = 1
vim.g.webdevicons_enable_airline_statusline = 1
vim.g.DevIconsEnableFoldersOpenClose = 1
vim.g.WebDevIconsNerdTreeAfterGlyphPadding = '  '
vim.g.WebDevIconsNerdTreeGitPluginForceVAlign = 1
vim.g.WebDevIconsUnicodeDecorateFileNodes = 1

-- Lua plugin configs
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
