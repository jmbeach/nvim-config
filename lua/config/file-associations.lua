-- Associate log files with log filetype
for _, v in ipairs({ "BufRead", "BufNewFile", "FileType" }) do
  vim.api.nvim_create_autocmd(v, {
    pattern = "*.log",
    callback = function()
      vim.bo.filetype = "log"
    end,
  })
end
