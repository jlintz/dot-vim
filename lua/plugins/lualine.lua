require('lualine').setup({
  options = {
    theme = 'OceanicNext',
    icons_enabled = true,
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
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
