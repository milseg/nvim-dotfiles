return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    scope = {
      show_start = false,
    },
    exclude = {
      filetypes = {
        'help',
        'terminal',
        'dashboard',
        'packer',
        'lspinfo',
        'TelescopePrompt',
        'TelescopeResults',
      },
      buftypes = {
        'terminal',
        'nvim-tree',
      },
    },
  }
}
