-- run python code
vim.keymap.set('', '<F5>', ':!python %<CR>')

-- toggle comments with Ctrl-c (uses built-in gc)
vim.keymap.set('n', '<C-c>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-c>', 'gc', { remap = true })

-- buffer navigation
vim.keymap.set('n', '<C-w>j', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<C-w>k', '<cmd>bnext<CR>')

-- tagbar
vim.keymap.set('n', '<C-i>', ':TagbarToggle<CR>', { silent = true })
