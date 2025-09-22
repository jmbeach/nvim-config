return {
  {
    'rest-nvim/rest.nvim',
    config = function()
      -- This makes rest.nvim json formatted
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'json',
        callback = function(ev)
          vim.bo[ev.buf].formatprg = 'jq --indent 4'
        end,
      })
    end,
  },
}
