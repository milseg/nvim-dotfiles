local actions = require('telescope.actions')

vim.cmd([[
  hi link TelescopePromptTitle PMenuSel
  hi link TelescopePreviewTitle PMenuSel
  hi link TelescopePromptNormal PMenu
  hi link TelescopePromptBorder PMenuBg
  hi link TelescopeNormal CursorLine
  hi link TelescopeBorder CursorLineBg
]])

require('telescope').setup({
  defaults = {
    path_display = { truncate = 1 },
    prompt_prefix = '   ',
    selection_caret = '  ',
    layout_config = {
      prompt_position = 'top',
    },
    preview = {
      timeout = 200,
    },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-Down>'] = actions.cycle_history_next,
        ['<C-Up>'] = actions.cycle_history_prev,
      },
    },
    file_ignore_patterns = { '.git/' },
  },
  -- extensions = {
  --   live_grep_args = {
  --     mappings = {
  --       i = {
  --         ["<C-P>"] = require("telescope-live-grep-args.actions").quote_prompt(),
  --         ["<C-N>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
  --       },
  --     },
  --   },
  -- },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      previewer = false,
      layout_config = {
        width = 80,
      },
    },
    oldfiles = {
      prompt_title = 'History',
    },
    lsp_references = {
      previewer = false,
    },
    -- lsp_definitions = {
    --   previewer = false,
    -- },
    -- lsp_document_symbols = {
    --   symbol_width = 55,
    -- },
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')

vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
vim.keymap.set('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
vim.keymap.set('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
vim.keymap.set('n', '<leader>h', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
