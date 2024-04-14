return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  build = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  dependencies = {
    { 'nvim-treesitter/playground', cmd = "TSPlaygroundToggle" },
    'hiphish/rainbow-delimiters.nvim',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-textobjects',
    "RRethy/nvim-treesitter-textsubjects",
  },
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      "tsx",
      "typescript",
      "javascript",
      "html",
      "comment",
      "css",
      "vue",
      "astro",
      "svelte",
      "gitcommit",
      "graphql",
      "json",
      "json5",
      "lua",
      "prisma",
      "vim"
    },
    auto_install = true,
    ignore_install = { "haskell" },
    highlight = {
      enable = true,
      -- disable = { "c", "rust" },  -- list of language that will be disabled
      -- additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = false,
      keymaps = {
        init_selection    = "Lm",
        node_incremental  = "lmm",
        scope_incremental = "<leader>lm",
        node_decremental  = "<C-l>m",
      },
    },
    indent = {
      enable = true
    },
    indent = {
      enable = true,
      disable = { "yaml" }
    },
    rainbow = {
      enable = true,
    },
    textobjects = {
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]]"] = "@function.outer",
          ["]m"] = "@class.outer",
        },
        goto_previous_start = {
          ["[["] = "@function.outer",
          ["[m"] = "@class.outer",
        },
        goto_next_end = {
          ["]["] = "@function.outer",
          ["]M"] = "@class.outer",
        },
        goto_previous_end = {
          ["[]"] = "@function.outer",
          ["[M"] = "@class.outer",
        },
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ia'] = '@parameter.inner',
          ['aa'] = '@parameter.outer',
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["~"] = "@parameter.inner",
        },
      },
    },
    textsubjects = {
      enable = true,
      prev_selection = '<BS>',
      keymaps = {
        ['<CR>'] = 'textsubjects-smart', -- works in visual mode
      }
    },
  },
  config = function (_, opts)
    require('ts_context_commentstring').setup({})
    vim.g.skip_ts_context_commentstring_module = true

    require('nvim-treesitter.configs').setup(opts)
  end,
}