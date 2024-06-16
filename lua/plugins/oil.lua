-- Open oil on leader + e
local open_oil = function()
  require('oil').toggle_float()
end

local open_oil_cwd = function()
  require('oil').toggle_float()
end

return {
  'stevearc/oil.nvim',
  tag = 'v2.8.0',
  config = function()
    require('oil').setup {
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<C-y>'] = 'actions.select',
        ['<C-s>'] = 'actions.select_vsplit',
        ['<C-h>'] = 'actions.select_split',
        ['<C-t>'] = 'actions.select_tab',
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['-'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = 'actions.tcd',
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
        ['q'] = 'actions.close',
      },
      float = {
        padding = 2,
        max_width = 200,
        max_height = 50,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
      },
    }
  end,
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    -- Open oil on leader + e
    { '<leader>e', open_oil, desc = 'Open file explorer' },
  },
}
