local is_shown = true
local Util = require 'utils.utils'

local toggle = function()
  is_shown = not is_shown
  require('lualine').hide { unhide = is_shown }
end
return {
  'nvim-lualine/lualine.nvim',
  init = function()
    -- set to visible. Something is causing it to get hidden
    require('lualine').hide { unhide = true }
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require 'lualine_require'
    lualine_require.require = require

    -- disable status line in favor of tabline
    vim.o.laststatus = 0

    local bar_config = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = {
        {
          'diagnostics',
          symbols = {
            error = ' ',
            warn = ' ',
            info = ' ',
            hint = ' ',
          },
        },
        {
          'buffers',
          buffers_color = {
            active = 'lualine_a_insert',
            inactive = 'lualine_c_inactive',
          },
          symbols = {
            alternate_file = ' ',
          },
        },
      },
      lualine_x = {
        {
          function()
            return '  ' .. require('dap').status()
          end,
          cond = function()
            return package.loaded['dap'] and require('dap').status() ~= ''
          end,
          color = Util.ui.fg 'Debug',
        },
        {
          require('lazy.status').updates,
          cond = require('lazy.status').has_updates,
          color = Util.ui.fg 'Special',
        },
        {
          'diff',
          symbols = {
            added = ' ',
            modified = ' ',
            removed = ' ',
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      },
      lualine_y = {
        { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
        { 'location', padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        { 'tabs' },
      },
    }
    return {
      options = {
        theme = 'everforest',
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'starter' } },
        section_separators = { left = '█', right = '█' },
        component_separators = { left = ' | ', right = ' | ' },
      },
      sections = {},
      inactive_sections = {},
      tabline = bar_config,
      extensions = { 'lazy' },
    }
  end,
  keys = {
    { '<leader>uS', toggle, desc = 'Toggle status line' },
  },
}
