require('ibl').setup({
  indent = { char = '┊' },
  exclude = {
            filetypes = {
                'lspinfo',
                'lazy',
                'checkhealth',
                'help',
                'man',
                'dashboard',
            }
   }
})
