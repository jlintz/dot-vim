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

-- Show trailing whitespace
vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'red' })
vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])

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
