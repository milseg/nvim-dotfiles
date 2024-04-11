
return {
  "jessarcher/onedark.nvim",
  priority = 1000,
  config = function()
    vim.cmd('colorscheme onedark')


    vim.api.nvim_set_hl(0, 'FloatBorder', {
        fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
        bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
    })

    vim.api.nvim_set_hl(0, 'CursorLineBg', {
      fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
      bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
    })

    vim.api.nvim_set_hl(0, 'Normal', {
      bg = '#181818',
    })

    -- Line number color
    vim.api.nvim_set_hl(0, 'LineNr', {
      fg = '#7b8293',
    })
    -- setting for  nvim tree ident line
    -- vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', {fg = '#30323E'})


    -- lualine settings. Makes separators hidden
    vim.api.nvim_set_hl(0, 'StatusLineNonText', {
      fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
      bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
    })

    -- indentation lines color
    vim.api.nvim_set_hl(0, 'IndentBlankLineChar', {
      fg = '#2F313C',
    })

    vim.api.nvim_set_hl(0, 'NeoTreeIndentMarker', {
      fg = '#2F313C',
    })

    vim.cmd([[
      highlight link Floaterm CursorLine
      highlight link FloatermBorder CursorLineBg
    ]])

  end,
}
