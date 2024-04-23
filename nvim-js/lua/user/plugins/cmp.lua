return {
  'hrsh7th/nvim-cmp',
  event = "InsertEnter",
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-calc",
    -- 'hrsh7th/cmp-copilot',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
   -- {
   --   "David-Kunz/cmp-npm",
   --   dependencies = { 'nvim-lua/plenary.nvim' },
   --   ft = "json",
   --   opts = {
   --     ignore = {},
   --     only_semantic_versions = true,
   --   },
   -- },
    "petertriho/cmp-git",
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    local lspkind = require('lspkind')
    local types = require("cmp.types")

    require("cmp_git").setup()
    require('luasnip/loaders/from_snipmate').lazy_load()


    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local source_map = {
      npm = "NPM",
      Codeium = "Codeium",
      buffer = "Buffer",
      nvim_lsp = "LSP",
      nvim_lsp_signature_help = "Signature",
      luasnip = "LuaSnip",
      nvim_lua = "Lua",
      path = "Path",
      calc = "Calculator",
      copilot = "Copilot",
    }

    local function ltrim(s)
      return s:match'^%s*(.*)'
    end

    local buffer_option = {
      -- Complete from all visible buffers (splits)
      get_bufnrs = function()
        local bufs = {}
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          bufs[vim.api.nvim_win_get_buf(win)] = true
        end
        return vim.tbl_keys(bufs)
      end,
    }

    local function limit_lsp_types(entry, ctx)
      local kind = entry:get_kind()
      local line = ctx.cursor.line
      local col = ctx.cursor.col
      local char_before_cursor = string.sub(line, col - 1, col - 1)
      local char_after_dot = string.sub(line, col, col)

      if char_before_cursor == "." and char_after_dot:match("[a-zA-Z]") then
        if
            kind == types.lsp.CompletionItemKind.Method
            or kind == types.lsp.CompletionItemKind.Field
            or kind == types.lsp.CompletionItemKind.Property
        then
          return true
        else
          return false
        end
      elseif string.match(line, "^%s+%w+$") then
        if kind == types.lsp.CompletionItemKind.Function or kind == types.lsp.CompletionItemKind.Variable then
          return true
        else
          return false
        end
      end

      return true
    end


    cmp.setup({
      preselect = false,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      view = {
        entries = { name = 'custom', selection_order = 'near_cursor' },
      },
      window = {
        completion = {
          col_offset = -2 -- align the abbr and word on cursor (due to fields order below)
        }
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = 'symbol',
          -- See: https://www.reddit.com/r/neovim/comments/103zetf/how_can_i_get_a_vscodelike_tailwind_css/
          before = function(entry, vim_item)
            -- Replace the 'menu' field with the kind and source
            vim_item.menu = '  ' .. vim_item.kind .. ' (' .. (source_map[entry.source.name] or entry.source.name) .. ')'
            vim_item.menu_hl_group = 'SpecialComment'

            vim_item.abbr = ltrim(vim_item.abbr)

            if vim_item.kind == 'Color' and entry.completion_item.documentation then
              local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
              if r then
                local color = string.format('%02x', r) .. string.format('%02x', g) ..string.format('%02x', b)
                local group = 'Tw_' .. color
                if vim.fn.hlID(group) < 1 then
                  vim.api.nvim_set_hl(0, group, {fg = '#' .. color})
                end
                vim_item.kind_hl_group = group
                return vim_item
              end
            end

            return vim_item
          end
        }),
      },
      mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
          -- print('tab...')
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
      },
      sources = {
        { 
          name = 'nvim_lsp',
          priority = 10,
          -- Limits LSP results to specific types based on line context (Fields, Methods, Variables)
          entry_filter = limit_lsp_types,
        },
        { 
          name = 'nvim_lsp_signature_help',
          priority = 10,
        },
        --{ name = "npm", keyword_length = 4, priority = 9 },
        { name = "codeium", priority = 9 },
        { name = "git", priority = 7 },
        {
          name = 'luasnip',
          priority = 7,
          max_item_count = 5,
        },
        { 
          name = 'buffer', 
          priority = 4,
          keyword_length = 5,
          max_item_count = 10,
          option = buffer_option,
        },
        { name = 'path', priority = 4 },
        { name = 'calc', priority = 3 },
      },
      experimental = {
        -- ghost_text = true,
      },
    })

    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })
  end,
}