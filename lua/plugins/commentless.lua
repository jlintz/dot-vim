require('commentless').setup({})

vim.keymap.set('n', '<leader>tc', require('commentless').toggle, { desc = 'Toggle comments' })
