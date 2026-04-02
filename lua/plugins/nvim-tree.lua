require('nvim-tree').setup({
  actions = {
    open_file = { quit_on_open = true },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
  },
  renderer = {
    icons = { show = { git = true, file = true, folder = true } },
  },
})

vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<C-o>', '<cmd>NvimTreeFindFile<CR>', { silent = true })
