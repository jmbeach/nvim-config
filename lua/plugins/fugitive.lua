return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>gg', ':tab G<cr>', mode = 'n', desc = 'Open Fugitive' },
  },
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = { 'FugitiveIndex' },
      group = vim.api.nvim_create_augroup('mine_fugitive', { clear = true }),
      callback = function()
        -- can add keymaps here
      end,
    })
  end,
}
