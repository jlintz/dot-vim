vim.opt.number = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.relativenumber = true

-- persistent undo; default undodir (~/.local/state/nvim/undo) is auto-created
vim.opt.undofile = true
vim.opt.undolevels = 1000

vim.opt.wildignore = { '*.swp', '*.bak', '*.pyc', '*.class' }

vim.opt.title = true

-- treesitter-aware folding (falls back to no folds where there's no parser)
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- don't autofold anything by default; zc/za turn folding back on
vim.opt.foldenable = false

-- none of these are word dividers
vim.opt.iskeyword:append({ '_', '$', '@', '%', '#' })

vim.opt.cursorline = true

-- sane tabstops
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.opt.background = 'dark'

-- so that some mapping still works when the cursor is at the end of file
vim.opt.virtualedit = 'onemore'

vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'

vim.opt.ttimeoutlen = 50
