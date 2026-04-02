require('lualine').setup({
  options = {
    theme = 'OceanicNext',
    icons_enabled = true,
  },
  tabline = {
    lualine_a = { { 'buffers', mode = 2 } },
    lualine_z = { 'tabs' },
  },
  extensions = {
      'fzf',
      'nvim-tree',
      'fugitive',
      'quickfix',
  }
})

for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, '<cmd>LualineBuffersJump! ' .. i .. '<CR>')
end
