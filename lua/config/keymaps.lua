-- run python code
vim.keymap.set('', '<F5>', ':!python %<CR>')

-- toggle comments with Ctrl-c (uses built-in gc)
vim.keymap.set('n', '<C-c>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-c>', 'gc', { remap = true })

-- buffer navigation
vim.keymap.set('n', '<C-w>j', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<C-w>k', '<cmd>bnext<CR>')

-- NOTE: <C-i> is the same keycode as <Tab>; mapping it breaks jumplist-forward,
-- the counterpart to <C-o>. Use <space>o (fzf lsp_document_symbols) for an outline.

-- undotree
vim.keymap.set("n", "<leader>u", require("undotree").open)
