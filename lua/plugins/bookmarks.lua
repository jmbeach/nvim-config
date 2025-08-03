return {
  'tomasky/bookmarks.nvim',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  event = 'VimEnter',
  config = function()
    require('bookmarks').setup {
      -- sign_priority = 8,  --set bookmark sign priority to cover other sign
      save_file = vim.fn.expand '$HOME/.bookmarks', -- bookmarks save file path
      keywords = {
        ['@t'] = '☑️ ', -- mark annotation startswith @t ,signs this icon as `Todo`
        ['@w'] = '⚠️ ', -- mark annotation startswith @w ,signs this icon as `Warn`
        ['@f'] = '⛏ ', -- mark annotation startswith @f ,signs this icon as `Fix`
        ['@n'] = ' ', -- mark annotation startswith @n ,signs this icon as `Note`
      },
      on_attach = function()
        local bm = require 'bookmarks'
        vim.keymap.set('n', '<leader>mm', bm.bookmark_toggle, { desc = 'Book[m]arks Toggle [M]ark' })
        vim.keymap.set('n', '<leader>mp', bm.bookmark_prev, { desc = 'Book[m]arks [P]rev' })
        vim.keymap.set('n', '<leader>mn', bm.bookmark_next, { desc = 'Book[m]arks [N]ext' })
        vim.keymap.set('n', '<leader>mi', bm.bookmark_ann, { desc = 'Book[m]arks [A]nnotate' })
        vim.keymap.set('n', '<leader>mc', bm.bookmark_clean, { desc = 'Book[m]arks [C]lean' })
        vim.keymap.set('n', '<leader>mx', bm.bookmark_clear_all, { desc = 'Book[m]arks [X]destroy all' })
      end,
    }
    require('telescope').load_extension 'bookmarks'
  end,
}
