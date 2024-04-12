

-- Plugin manager installation
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  -- Color scheme
  { import = 'user.plugins.onedark' },

  -- Add comments with gc/gcc commands
  {
    'tpope/vim-commentary',
    config = function()
      -- Maintain cursor position
      vim.keymap.set('n', 'gcap', 'my<cmd>norm vip<bar>gc<cr>`y')
    end,
  },

  -- Change/delete surrounding character with cs, ds
  { 'tpope/vim-surround' },

  -- Useful commands like :Rename and :SudoWrite
  { 'tpope/vim-eunuch' },

  -- Pairs of handy bracket mappings, like [b and ]b
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },

  -- Indent autodetection with editorconfig support.
  { 'tpope/vim-sleuth' },

  -- Allow plugins to enable repeating of commands, just like native vim commands
  { 'tpope/vim-repeat' },

  -- Navigate seamlessly(Ctrl-[hjkl]) between Vim windows and Tmux panes
  { 'christoomey/vim-tmux-navigator' },

  -- Place cursor the last place it was when reopening a file
  { 'farmergreg/vim-lastplace' },

  -- Enable * searching with visually selected text.
  { 'nelstrom/vim-visual-star-search' },

  -- Automatically create parent dirs when saving a file.
  { 'jessarcher/vim-heritage' },

  -- Sets working directory to the project root
  {
    'airblade/vim-rooter',
    init = function()
      -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
      vim.g.rooter_manual_only = 1
      vim.g.rooter_patterns = {'.git', 'composer.json'}
    end,
    config = function()
      vim.cmd('Rooter')
    end,
  },

  -- Automatically add closing brackets, quotes, etc.
  { 'windwp/nvim-autopairs', config = true },

  -- Add smooth scrolling to avoid jarring jumps
  { 'karb94/neoscroll.nvim', opts = { easing_function = "cubic" } },

  -- delete buffer without closing the window
  {
    'famiu/bufdelete.nvim',
    config = function()
      vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
      vim.keymap.set('n', '<Leader>Q', ':bufdo Bdelete<CR>')
    end,
  },

  -- Split arrays and methods onto multiple lines, or join them back up into one with gS and gJ
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { 'gJ', function() require('treesj').join() end },
      { 'gS', function() require('treesj').split() end },
    },
    opts = {
      use_default_keymaps = false,
    },
  },

  -- Automatically fix indentation when pasting code.
  {
    'sickill/vim-pasta',
    config = function()
      vim.g.pasta_disabled_filetypes = { 'fugitive' }
    end,
  },

  -- Fuzzy finder
  { import = 'user.plugins.telescope' },

  -- File tree
  { import = 'user.plugins.neo-tree' },

  -- A Status line.
  -- @TODO remove from the nvim-minimal configuration
  { import = 'user.plugins.lualine' },

  { "echasnovski/mini.bufremove", version = "*", opts = { silent = true } },

  -- Display buffers as tabs.
  { import = 'user.plugins.bufferline' },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      scope = {
        show_start = false,
      },
      exclude = {
        filetypes = {
          'neo-tree',
          'dashboard',
        },
        buftypes = {
          'terminal',
        },
      },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = {
      { ']h', ':Gitsigns next_hunk<CR>'},
      { '[h', ':Gitsigns prev_hunk<CR>'},
      { 'gs', ':Gitsigns stage_hunk<CR>'},
      { 'gS', ':Gitsigns undo_stage_hunk<CR>'},
      { 'gp', ':Gitsigns preview_hunk<CR>'},
      { 'gb', ':Gitsigns blame_line<CR>'},
    },
    opts = {
      signs = {
        add = { text = '|' },
        change = { text = '⢕' },
      },
    },
  },

  { 'tpope/vim-fugitive', dependencies = 'tpope/vim-rhubarb' },

  {
    'voldikss/vim-floaterm',
    keys = {
      { '<F1>', ':FloatermToggle<CR>' },
      { '<F1>', '<C-\\><C-n>:FloatermToggle<CR>', mode = 't' },
    },
    cmd = { 'FloatermToggle' },
    init = function()
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
    end,
  },

  -- Improved syntax highlighting
  { import = 'user.plugins.treesitter' },

  -- Language Server Protocol.
  { import = 'user.plugins.lspconfig' },

  -- Decent typescript Language Server
  { import = 'user.plugins.typescript-tools' },

  -- type checker
  { "dmmulroy/tsc.nvim", event = 'VeryLazy', opts = { flags = { watch= true } } },

  -- Completion
  { import = 'user.plugins.cmp' },

  -- vscode-like pictograms to neovim built-in lsp
  { "onsails/lspkind-nvim" },

  -- hex code colorizer
  { 'NvChad/nvim-colorizer.lua', opts = { user_default_options = { names = false, } }, },

  -- highlight occurrences of the word under the cursor
  { 
    'RRethy/vim-illuminate', event = 'VeryLazy', 
    config = function()
      require('illuminate').configure({
        min_count_to_highlight = 2,
        delay = 1000,
        providers = { 'lsp' },
      })
    end, 
  },

  -- Auto add/remove backticks when adding/removing template strings
  { "axelvc/template-string.nvim", event = "InsertEnter", ft = { "javascript", "typescript", "javascriptreact", "typescriptreact", }, config = true, },

  -- ╭─────────────────────────────────────────────────────────╮
  -- │ AI                                                      │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    "jcdickinson/codeium.nvim",
    event = "InsertEnter",
    cmd = "Codeium",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = true,
  },

  {
    "robitx/gp.nvim",
    opts = {
      openai_api_key = require('localenv').openai_api_key
    },
  },

}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { "onedark" },
  },
  concurrency = 5,
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tutor",
        "zipPlugin",
      },
    },
  },
  debug = false
})
