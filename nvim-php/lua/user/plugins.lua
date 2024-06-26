local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()
require('packer').init({
    compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
    display = {
        open_fn = function()
            return require('packer.util').float({border = 'solid'})
        end,
    },
})

local use = require('packer').use

use 'wbthomason/packer.nvim'
-- Colorschemes
use({
    'jessarcher/onedark.nvim',
    config = function ()
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
    end,
})
-- My plugins here
-- Add comments with gc/gcc commands
use 'tpope/vim-commentary'

-- Change/delete surrounding character with cs, ds ---
use 'tpope/vim-surround'

-- Useful commands like :Rename and :SudoWrite
use 'tpope/vim-eunuch'

-- Pairs of handy bracket mappings, like [b and ]b
use 'tpope/vim-unimpaired'

-- Indent autodetection with editorconfig support
use "tpope/vim-sleuth"

-- Allow plugins to enable repeating of commands with dot character, just like native vim commands
use 'tpope/vim-repeat'

-- Add and improve programming languages definitions
use 'sheerun/vim-polyglot'

-- Navigate seamlessly(Ctrl-[hjkl]) between Vim windows and Tmux panes
use 'christoomey/vim-tmux-navigator'

-- Place cursor the last place it was when reopening a file
use 'farmergreg/vim-lastplace'

-- Enable searching with visually selected text (press * key)
use 'nelstrom/vim-visual-star-search'

-- Automatically create parent folders if it does not exist when creating new files
use 'jessarcher/vim-heritage'

-- Allow html tags attributes manipulation using the verbs ix and ax
use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = 'kana/vim-textobj-user',
})


-- Sets working directory to the project root
use({
  'airblade/vim-rooter',
  setup = function()
    -- only sets root when vim starts
    vim.g.rooter_manual_only = 1
  end,
  config = function()
    vim.cmd('Rooter')
  end,
})

-- Automatically add closing brackets, quotes, etc
use({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end,
})

-- Add smooth scrolling to avoid jarring jumps
use({
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup()
  end,
})

-- delete buffer without closing the window
use({
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
    --vim.keymap.set('n', '<Leader>Q', ':bufdo Bdelete<CR>')
  end,
})

-- Split arrays and methods onto multiple lines, or join them back up into one with gS and gJ
use({
  'AndrewRadev/splitjoin.vim',
  config = function()
    vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
    vim.g.splitjoin_trailing_comma = 1
    vim.g.splitjoin_php_method_chain_full = 1
  end,
})

use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})

use({
   'nvim-telescope/telescope.nvim',
   requires = {
     'nvim-lua/plenary.nvim',
     'kyazdani42/nvim-web-devicons',
     'nvim-telescope/telescope-live-grep-args.nvim',
     { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
   },
   config = function()
     require('user/plugins/telescope')
   end,
})

use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user/plugins/nvim-tree')
    -- require('nvim-tree').setup()
  end,
})

use({
  'nvim-lualine/lualine.nvim',
  requires = {
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
    require('user/plugins/lualine')
  end,
})

-- Display buffers as tabs.
use({
  'akinsho/bufferline.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  after = 'onedark.nvim',
  config = function()
    require('user/plugins/bufferline')
    -- require('bufferline').setup()
  end,
})

-- Display indentation lines.
use({
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    require('user/plugins/indent-blankline')
    -- require('ibl').setup()
  end,
})

-- Add a dashboard.
use({
  'glepnir/dashboard-nvim',
  config = function()
    require('user/plugins/dashboard-nvim')
  end
})

-- Git integration.
use({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      signs = {
        add = { text = '⢕' },
        change = { text = '⢕' },
      },
    })
    vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
    vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
    vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
    vim.keymap.set('n', 'gS', ':Gitsigns undo_stage_hunk<CR>')
    vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
    vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
  end,
})

-- Git commands.
use({
  'tpope/vim-fugitive',
  requires = 'tpope/vim-rhubarb',
})

--- Floating terminal.
use({
  'voldikss/vim-floaterm',
  config = function()
    require('user/plugins/floaterm')
  end
})

-- Improved syntax highlighting
use({
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  requires = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('user/plugins/treesitter')
  end,
})

-- Language Server Protocol.
use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    require('user/plugins/lspconfig')
  end,
})


-- Completion engine
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp', -- get information from language server
    'hrsh7th/cmp-nvim-lsp-signature-help', -- help autocomplete on typing methods
    'hrsh7th/cmp-buffer', -- allows autocomplete from buffer
    'hrsh7th/cmp-path', -- allows autocomplete form filesystem paths
    -- 'hrsh7th/cmp-copilot',
    'L3MON4D3/LuaSnip', -- snippet engine
    'saadparwaiz1/cmp_luasnip', -- integrates snippet engine with completion engine
    'onsails/lspkind-nvim', -- eyecandy for differentiating between language elements(functions, classes, variables, etc...)
  },
  config = function()
    require('user/plugins/cmp')
  end,
})

-- PHP Refactoring Tools
use({
  'phpactor/phpactor',
  ft = 'php',
  -- run = 'composer install --no-dev --optimize-autoloader',
  config = function()
    vim.keymap.set('n', '<Leader>pm', ':PhpactorContextMenu<CR>')
    vim.keymap.set('n', '<Leader>pn', ':PhpactorClassNew<CR>')
  end,
})


-- Project Configuration.
use({
  'tpope/vim-projectionist',
  requires = 'tpope/vim-dispatch',
  config = function()
    require('user/plugins/projectionist')
  end,
})

-- Testing helper
use({
  'vim-test/vim-test',
  config = function()
    require('user/plugins/vim-test')
  end,
})


-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end


-- vim.cmd([[
--  augroup packer_user_config
--    autocmd!
--    autocmd BufWritePost plugins.lua source <afile>
--  augroup end
--]])
