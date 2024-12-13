local function augroup(name)
  return vim.api.nvim_create_augroup('mine_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'text', 'gitcommit', 'markdown', 'help' },
  group = augroup 'text_settings',
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.linebreak = true
    vim.keymap.set('n', 'j', 'gj', { buffer = true })
    vim.keymap.set('n', 'k', 'gk', { buffer = true })
  end,
})

-- Goyo stuff
vim.api.nvim_create_autocmd('User', {
  pattern = 'GoyoEnter',
  group = augroup 'zen',
  callback = function()
    vim.cmd 'Limelight'
    require('lualine').hide()
    vim.cmd 'GitBlameDisable'
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'GoyoLeave',
  group = augroup 'zen',
  callback = function()
    vim.cmd 'Limelight!'
    require('lualine').hide { unhide = true }
    vim.cmd 'GitBlameEnable'
  end,
})

local fileTypes = {
  ['*.ah2'] = 'autohotkey',
  ['*.log'] = 'log',
}

for extension, filetype in pairs(fileTypes) do
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'FileType' }, {
    pattern = extension,
    group = augroup 'filetypes',
    callback = function()
      vim.bo.filetype = filetype
    end,
  })
end

-- Rest stuff
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'http',
  group = augroup 'rest',
  callback = function()
    vim.keymap.set('n', '<leader>cr', '<cmd>Rest run<cr>', { desc = 'Rest Run' })
    vim.keymap.set('n', '<leader>ce', '<cmd>Rest env select<cr>', { desc = 'Rest env select' })
  end,
})
