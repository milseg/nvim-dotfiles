local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function (prompt_bufnr, map)
      local actions = require "telescope.actions"
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require "telescope.actions.state"
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if (filename == nil) then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end
  }
end

local function diffFiles(state)
  local node = state.tree:get_node()
  local log = require("neo-tree.log")
  state.clipboard = state.clipboard or {}
  if diff_Node and diff_Node ~= tostring(node.id) then
    local current_Diff = node.id
    require("neo-tree.utils").open_file(state, diff_Node, open)
    vim.cmd("vert diffs " .. current_Diff)
    log.info("Diffing " .. diff_Name .. " against " .. node.name)
    diff_Node = nil
    current_Diff = nil
    state.clipboard = {}
    require("neo-tree.ui.renderer").redraw(state)
  else
    local existing = state.clipboard[node.id]
    if existing and existing.action == "diff" then
      state.clipboard[node.id] = nil
      diff_Node = nil
      require("neo-tree.ui.renderer").redraw(state)
    else
      state.clipboard[node.id] = { action = "diff", node = node }
      diff_Name = state.clipboard[node.id].node.name
      diff_Node = tostring(state.clipboard[node.id].node.id)
      log.info("Diff source file " .. diff_Name)
      require("neo-tree.ui.renderer").redraw(state)
    end
  end
end



return {
  'nvim-neo-tree/neo-tree.nvim',
  cmd = 'Neotree',
  keys = {
    { '<leader>n', ':Neotree reveal toggle<CR>' },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    {
      's1n7ax/nvim-window-picker',
      opts = {
        filter_rules = {
          autoselect_one = true,
          include_current_win = false,
          bo = {
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            buftype = { 'terminal', "quickfix" },
          },
        },
        highlights = {
          statusline = {
            focused = {
              bg = '#9d7cd8',
            },
            unfocused = {
              bg = '#4d2c88',
            },
          },
        },
      },
    },
  },
  opts = {
    close_if_last_window = true,
    hide_root_node = true,
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    source_selector = {
      winbar = true,
      statusline = false,
      separator = { left = "", right= "" },
      show_separator_on_edge = true,
      highlight_tab = "SidebarTabInactive",
      highlight_tab_active = "SidebarTabActive",
      highlight_background = "StatusLine",
      highlight_separator = "SidebarTabInactiveSeparator",
      highlight_separator_active = "SidebarTabActiveSeparator",
    },
    default_component_configs = {
      indent = {
        padding = 0,
      },
      name = {
        use_git_status_colors = false,
        highlight_opened_files = true,
      },
    },
    window = {
      mappings = {
        ["<cr>"] = "open_with_window_picker",
        ['te'] = "Neotree show filesystem left",
        ['tb'] = "Neotree show buffers left",
        ['ti'] = "Neotree show git_status left",
        ["tf"] = "telescope_find",
        ["tg"] = "telescope_grep",
        ["tD"] = "diff_files",
        ["o"] = "open_and_clear_filter",
      },
    },
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').find_files(getTelescopeOpts(state, path))
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require('telescope.builtin').live_grep(getTelescopeOpts(state, path))
      end,
      open_and_clear_filter = function (state)
        local node = state.tree:get_node()
        if node and node.type == "file" then
          local file_path = node:get_id()
          -- reuse built-in commands to open and clear filter
          local cmds = require("neo-tree.sources.filesystem.commands")
          cmds.open(state)
          cmds.clear_filter(state)
          -- reveal the selected file without focusing the tree
          require("neo-tree.sources.filesystem").navigate(state, state.path, file_path)
        end
      end,
      diff_files = diffFiles,
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
        },
      },
      -- follow_current_file = {
      --   enabled = true,
      -- },
      group_empty_dirs = true,

    },
  },
}
