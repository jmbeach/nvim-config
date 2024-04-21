-- I don't want to remember the word "Goyo". "Zen" mode is what I actually want
vim.api.nvim_create_user_command("Zen", function()
  vim.api.nvim_command("Goyo")
end, {})

vim.g.limelight_conceal_ctermfg = "gray"
vim.g.limelight_conceal_ctermbg = 240
vim.g.limelight_conceal_guifg = "DarkGray"
vim.g.limelight_conceal_guifg = "#777777"
vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoEnter",
  callback = function()
    vim.cmd("Limelight")
    require("lualine").hide()
    vim.cmd("GitBlameDisable")
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "GoyoLeave",
  callback = function()
    vim.cmd("Limelight!")
    require("lualine").hide({ unhide = true })
    vim.cmd("GitBlameEnable")
  end,
})
