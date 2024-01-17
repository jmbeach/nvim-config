vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.log",
  callback = function()
    vim.bo.filetype = "log"
  end,
})
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.log",
  callback = function()
    vim.bo.filetype = "log"
  end,
})
