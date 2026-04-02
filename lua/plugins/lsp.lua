-- Mason + LSP setup
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyrefly', 'jsonls', 'yamlls', 'bashls', 'gopls', 'html', 'cssls',
    'ansiblels', 'nginx_language_server',
  },
})

local servers = { 'jsonls', 'yamlls', 'bashls', 'gopls', 'html', 'cssls', 'ansiblels', 'nginx_language_server' }
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end
vim.lsp.enable(servers)

-- LSP keymaps (applied when a server attaches to a buffer)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
    map('n', 'gy', vim.lsp.buf.type_definition, 'Go to type definition')
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
    map('n', 'gr', vim.lsp.buf.references, 'Go to references')

    map('n', '[g', vim.diagnostic.goto_prev, 'Previous diagnostic')
    map('n', ']g', vim.diagnostic.goto_next, 'Next diagnostic')
    map('n', '<leader>?', vim.diagnostic.open_float, 'Show diagnostic')

    map('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, 'Hover documentation')
    map('i', '<C-k>', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, 'Signature help')

    map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')

    map({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, 'Code action')
    map('n', '<leader>ac', vim.lsp.buf.code_action, 'Code action')
    map('n', '<leader>qf', vim.lsp.buf.code_action, 'Quick fix')

    map({ 'n', 'x' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, 'Format')

    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd('CursorHold', {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd('CursorMoved', {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})

-- Diagnostic display
vim.diagnostic.config({
  virtual_text = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '✘',
      [vim.diagnostic.severity.WARN] = '⚠',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
  float = { border = 'rounded' },
  update_in_insert = false,
})
