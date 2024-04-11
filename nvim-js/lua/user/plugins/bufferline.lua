local inactiveBg = {
  bg = { attribute = 'bg', highlight = 'BufferlineInactive' },
}


local function setupBufferline()
  local bufferline = require("bufferline")
  bufferline.setup({
    options = {
      close_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      right_mouse_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
      show_buffer_close_icons = false,
      --separator_style = { "|", "|" },
      always_show_bufferline = true,
      style_preset = bufferline.style_preset.no_italic,
      numbers = function(opts)
        return string.format("%s", opts.ordinal)
      end,
      custom_filter = function(buf_number)
        -- filter out filetypes you don't want to see
        if vim.bo[buf_number].filetype ~= "qf" then
          return true
        end
      end,
      indicator = {
        icon = ' ',
      },
      show_close_icon = false,
      max_name_length = 25,
      separator_style = 'slant',
      modified_icon = '',
      custom_areas = {
        left = function()
          return {
            { text = '    ', fg = '#8fff6d' },
          }
        end,
      },
      offsets = {
        {
          filetype = 'neo-tree',
          text = function()
            return ' '..vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
          end,
          highlight = 'StatusLineComment',
          text_align = 'left',
        },
      },
    }
  })
end

return {
  'akinsho/bufferline.nvim',
  event = "VeryLazy",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'echasnovski/mini.bufremove',
  },
  version = "*",
  config = function()
    setupBufferline()
  end,
  keys = {
    { "<Leader>1",    "<cmd>BufferLineGoToBuffer 1<CR>" },
    { "<Leader>2",    "<cmd>BufferLineGoToBuffer 2<CR>" },
    { "<Leader>3",    "<cmd>BufferLineGoToBuffer 3<CR>" },
    { "<Leader>4",    "<cmd>BufferLineGoToBuffer 4<CR>" },
    { "<Leader>5",    "<cmd>BufferLineGoToBuffer 5<CR>" },
    { "<Leader>6",    "<cmd>BufferLineGoToBuffer 6<CR>" },
    { "<Leader>7",    "<cmd>BufferLineGoToBuffer 7<CR>" },
    { "<Leader>8",    "<cmd>BufferLineGoToBuffer 8<CR>" },
    { "<Leader>9",    "<cmd>BufferLineGoToBuffer 9<CR>" },
    { "<Leader>bb",  "<cmd>BufferLineMovePrev<CR>",                desc = "Move back" },
    { "<Leader>bn",  "<cmd>BufferLineMoveNext<CR>",                desc = "Move next" },
    { "<Leader>bl",  "<cmd>BufferLineCloseLeft<CR>",               desc = "Close Left" },
    { "<Leader>br",  "<cmd>BufferLineCloseRight<CR>",              desc = "Close Right" },
    { "<Leader>bp",  "<cmd>BufferLinePick<CR>",                    desc = "Pick Buffer" },
    { "<Leader>bP",  "<cmd>BufferLineTogglePin<CR>",               desc = "Pin/Unpin Buffer" },
    { "<Leader>bse", "<cmd>BufferLineSortByExtension<CR>",         desc = "Sort by extension" },
    { "<Leader>bsd", "<cmd>BufferLineSortByDirectory<CR>",         desc = "Sort by directory" },
    { "<Leader>bsr", "<cmd>BufferLineSortByRelativeDirectory<CR>", desc = "Sort by relative dir" },
  },
  highlights = {
    fill = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    background = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    tab = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    tab_close = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    close_button = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
      fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
    },
    close_button_visible = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
      fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
    },
    close_button_selected = {
      fg = { attribute = 'fg', highlight = 'StatusLineNonText' },
    },
    buffer_visible = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    modified = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    modified_visible = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    duplicate = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    duplicate_visible = {
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    separator = {
      fg = { attribute = 'bg', highlight = 'StatusLine' },
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    separator_selected = {
      fg = { attribute = 'bg', highlight = 'StatusLine' },
      bg = { attribute = 'bg', highlight = 'Normal' }
    },
    separator_visible = {
      fg = { attribute = 'bg', highlight = 'StatusLine' },
      bg = { attribute = 'bg', highlight = 'StatusLine' },
    },
    -- Diagnostic
    diagnostic = inactiveBg,
    diagnostic_visible = inactiveBg,
    hint_diagnostic = inactiveBg,
    hint_diagnostic_visible = inactiveBg,
    info_diagnostic = inactiveBg,
    info_diagnostic_visible = inactiveBg,
    warning_diagnostic = inactiveBg,
    warning_diagnostic_visible = inactiveBg,
    error_diagnostic = inactiveBg,
    error_diagnostic_visible = inactiveBg,
  },
}
