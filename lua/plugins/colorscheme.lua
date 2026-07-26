-- these must be set before the colorscheme loads or they have no effect
vim.g.oceanic_next_terminal_bold = 1
vim.g.oceanic_next_terminal_italic = 1

vim.cmd.colorscheme('gruvbox')

-- LSP floating window colors
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#1b2b34' })
vim.api.nvim_set_hl(0, 'FloatBorder', { fg = '#65737e', bg = '#1b2b34' })
