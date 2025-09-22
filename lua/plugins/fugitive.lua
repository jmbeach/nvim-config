return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>gg', ':tab G<cr>', mode = 'n', desc = 'Open Fugitive' },
  },
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'gitcommit' },
      group = vim.api.nvim_create_augroup('my_gitcommit', { clear = true }),
      callback = function()
        vim.cmd 'wincmd H'
      end,
    })
  end,
}
