require('nvim-tree').setup({
  git = {
    ignore = false,
  },
  view = {
    width = 40,
  },
  renderer = {
    highlight_opened_files = 'name',
    group_empty = true,
    icons = {
      show = {
        folder_arrow = false,
      },
      -- glyphs = {
      --   git = {
      --     unstaged = "◌",
      --     untracked = "󰐕",
      --     ignored = "󱙄",
      --   },
      -- },
    },
    indent_markers = {
      enable = true,
    },
  },
  filters = {
    custom = {
      "^\\.ide.php$",
      "^\\.git$",
    },
  },
})


--Opens the tree focused on the current file
vim.keymap.set('n', '<Leader>n', ':NvimTreeFindFileToggle<CR>', { silent = true })
