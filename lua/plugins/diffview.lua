return {
  'sindrets/diffview.nvim',
  opts = function(_, opts)
    opts.keymaps = {
      view = {
        { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'Close diffview' } },
      },
      file_panel = {
        { 'n', 'q', '<Cmd>DiffviewClose<CR>', { desc = 'Close diffview' } },
      },
    }
  end,
  keys = function(_, keys)
    return vim.list_extend({
      { 'n', '<leader>gd', '<Cmd>DiffviewOpen<CR>', { desc = 'Open diffview' } },
    }, keys)
  end,
}
