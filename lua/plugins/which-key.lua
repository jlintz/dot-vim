local wk = require('which-key')

wk.setup({})

-- label the leader prefixes so the popup is readable
wk.add({
    { '<leader>c', group = 'claude code' },
    { '<leader>d', group = 'diagnostics' },
    { '<leader>h', group = 'git hunks' },
    { '<leader>t', group = 'toggles' },
    { '<leader>r', group = 'refactor' },
})
