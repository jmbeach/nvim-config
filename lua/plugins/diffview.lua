return {
  'sindrets/diffview.nvim',
  opts = function(_, opts)
    opts.keymaps = {
      view = {},
      file_panel = {},
    }
  end,
  keys = function(_, keys)
    return vim.list_extend({
      { '<leader>gd', '<Cmd>DiffviewOpen<CR>', { desc = 'Open diffview' } },
    }, keys)
  end,
}
