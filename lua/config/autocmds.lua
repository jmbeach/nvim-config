local function augroup(name)
  return vim.api.nvim_create_augroup('mine_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'text', 'gitcommit', 'markdown' },
  group = augroup 'text_settings',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.linebreak = true
  end,
})

-- Goyo stuff
vim.api.nvim_create_autocmd('User', {
  pattern = 'GoyoEnter',
  callback = function()
    vim.cmd 'Limelight'
    require('lualine').hide()
    vim.cmd 'GitBlameDisable'
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'GoyoLeave',
  callback = function()
    vim.cmd 'Limelight!'
    require('lualine').hide { unhide = true }
    vim.cmd 'GitBlameEnable'
  end,
})
