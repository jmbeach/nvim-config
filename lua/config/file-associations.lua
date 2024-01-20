local fileTypes = {
  ["*.ah2"] = "autohotkey",
  ["*.log"] = "log",
}

for extension, filetype in pairs(fileTypes) do
  for _, v in ipairs({ "BufRead", "BufNewFile", "FileType" }) do
    vim.api.nvim_create_autocmd(v, {
      pattern = extension,
      callback = function()
        vim.bo.filetype = filetype
      end,
    })
  end
end
