-- I don't want to remember the word "Goyo". "Zen" mode is what I actually want
vim.api.nvim_create_user_command('Zen', function()
  vim.api.nvim_command 'Goyo'
end, {})

-- limelight settings
vim.g.limelight_conceal_ctermfg = 'gray'
vim.g.limelight_conceal_ctermbg = 240
vim.g.limelight_conceal_guifg = 'DarkGray'
vim.g.limelight_conceal_guifg = '#777777'
