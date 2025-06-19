return {
  'sindrets/diffview.nvim',
  lazy = false,
  opts = function(_, opts)
    opts.keymaps = {
      view = {},
      file_panel = {},
    }
  end,
  keys = function(_, keys)
    return vim.list_extend({
      { '<leader>gd', '<Cmd>DiffviewOpen<CR>', { desc = 'Open diffview' } },
      { '<leader>gh', '<Cmd>DiffviewFileHistory<CR>', { desc = '[G]it [H]istory for File' } },
    }, keys)
  end,
}
