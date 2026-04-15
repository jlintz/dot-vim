require('fzf-lua').setup({
    fzf_colors = true,
})

vim.keymap.set('n', '<C-P>', '<cmd>FzfLua files<CR>')
vim.keymap.set('n', '<C-G>', '<cmd>FzfLua live_grep<CR>')

-- LSP list mappings (replaces CoCList)
vim.keymap.set('n', '<space>a', '<cmd>FzfLua diagnostics_workspace<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>c', '<cmd>FzfLua lsp_code_actions<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>o', '<cmd>FzfLua lsp_document_symbols<CR>', { silent = true, nowait = true })
vim.keymap.set('n', '<space>s', '<cmd>FzfLua lsp_workspace_symbols<CR>', { silent = true, nowait = true })
