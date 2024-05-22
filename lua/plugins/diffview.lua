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
}
