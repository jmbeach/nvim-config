-- I don't want to remember the word "Goyo". "Zen" mode is what I actually want
vim.api.nvim_create_user_command("Zen", function()
  vim.api.nvim_command("Goyo")
end, {})
