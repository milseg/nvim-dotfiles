local separator = { '"▏"', color = 'StatusLineNonText' }

return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  dependencies = {
    'arkav/lualine-lsp-progress',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      section_separators = '',
      component_separators = '',
      globalstatus = true,
      theme = {
        normal = {
          a = 'StatusLine',
          b = 'StatusLine',
          c = 'StatusLine',
        },
      },
    },
    sections = {
      lualine_a = {
        'mode',
        separator,
      },
      lualine_b = {
        'branch',
        {
        'diff',
          symbols = { added = ' ', modified = ' ', removed = ' ' },
        },
        function ()
          return '󰅭 ' .. vim.pesc(tostring(#vim.tbl_keys(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() }))) or '')
        end,
        { 'diagnostics', sources = { 'nvim_diagnostic' } },
      },
      lualine_c = {
        { 'filename', file_status = true, path = 1 }
      },
      lualine_x = {
        'filetype',
        'encoding',
        'fileformat',
        '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
        separator,
      },
      lualine_y = {
        'searchcount',
        'selectioncount',
      },
      lualine_z = {
        'location',
        'progress',
      },
    },
  },
}
