-- Open oil on leader + e
local open_oil = function()
  vim.cmd 'vsplit | wincmd h | vertical resize 50'
  require('oil').open()
end

local select = function()
  entry = require('oil').get_cursor_entry()
  require('oil').select()
  -- Close the oil window if the selecttion is not a directory
  -- and more than one window is open
  if entry and entry.type == 'file' and vim.fn.winnr '$' > 1 then
    vim.cmd 'close'
  end
end

return {
  'stevearc/oil.nvim',
  tag = 'v2.8.0',
  config = function()
    require('oil').setup {
      keymaps = {
        ['g?'] = 'actions.show_help',
        ['<C-s>'] = 'actions.select_vsplit',
        ['<CR>'] = select,
        ['<C-y'] = select,
        ['<C-t>'] = 'actions.select_tab',
        ['<C-p>'] = 'actions.preview',
        ['<C-c>'] = 'actions.close',
        ['<C-h>'] = function()
          vim.cmd 'wincmd h'
        end,
        ['<C-l>'] = function()
          vim.cmd 'wincmd l'
        end,
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
