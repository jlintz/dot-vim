local ts_languages = { 'python', 'bash', 'yaml', 'go', 'json', 'lua', 'vim', 'toml', 'hcl', 'ini', 'markdown',
    'markdown_inline', 'nginx', 'terraform', 'zsh', 'sql' }
require('nvim-treesitter').install(ts_languages)

-- Match on the parser language, not the filetype: several filetypes map to a
-- differently named parser (dosini -> ini, sh -> bash), and those never started
-- back when this autocmd matched filetypes directly.
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang or not vim.tbl_contains(ts_languages, lang) then return end

        vim.treesitter.start(ev.buf, lang)
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
