local ts_languages = { 'python', 'bash', 'yaml', 'go', 'json', 'lua', 'vim', 'toml', 'hcl' }
require('nvim-treesitter').install(ts_languages)

vim.api.nvim_create_autocmd('FileType', {
    pattern = ts_languages,
    callback = function() vim.treesitter.start() end,
})
