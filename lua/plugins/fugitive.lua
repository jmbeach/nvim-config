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
        -- 1. Open the commit buffer in a new tab
        vim.cmd 'wincmd T'

        -- 2. Create a vertical split (Copy of the buffer)
        vim.cmd 'vsplit'

        -- Search for the specific git instruction line and scroll it to the top
        -- We search for the line starting with "# Everything below"
        if vim.fn.search([[^# Everything below]], 'w') > 0 then
          vim.cmd 'normal! zt'
        end

        -- Move focus back to the Left window (Writing window)
        vim.cmd 'wincmd h'
        local width = math.floor(vim.o.columns * 0.4)
        vim.cmd('vertical resize ' .. width)
      end,
    })
  end,
}
