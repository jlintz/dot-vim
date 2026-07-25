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

-- Show trailing whitespace. matchadd() is window-local, so it has to run for
-- every window, and the highlight has to be re-declared after a colorscheme load.
local function set_extra_whitespace_hl()
    vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = 'red' })
end
set_extra_whitespace_hl()
vim.api.nvim_create_autocmd('ColorScheme', { callback = set_extra_whitespace_hl })

vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter' }, {
    callback = function()
        if vim.w.extra_whitespace_match or vim.bo.buftype ~= '' then return end
        vim.w.extra_whitespace_match = vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])
    end,
})

-- Format on save
vim.g.autoformat = true
vim.api.nvim_create_autocmd('BufWritePre', {
    callback = function()
        if vim.g.autoformat and vim.b.autoformat ~= false then
            vim.lsp.buf.format({ async = false })
        end
    end,
})

-- User commands
vim.api.nvim_create_user_command('Format', function()
    vim.lsp.buf.format({ async = true })
end, {})

vim.api.nvim_create_user_command('FormatToggle', function()
    vim.g.autoformat = not vim.g.autoformat
    print('autoformat: ' .. tostring(vim.g.autoformat))
end, {})

vim.api.nvim_create_user_command('FormatToggleBuffer', function()
    vim.b.autoformat = not (vim.b.autoformat ~= false)
    print('buffer autoformat: ' .. tostring(vim.b.autoformat))
end, {})

vim.api.nvim_create_user_command('OR', function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
end, {})
