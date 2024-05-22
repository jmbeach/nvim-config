local map = vim.keymap.set

-- see messages
map('n', '<leader>xm', '<cmd>messages<cr>', { desc = 'Messages' })
map('n', '<leader>y', '"+yy', { desc = 'Copy line to clipboard' })

-- copy / paste to clipboard
map('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
map('n', '<leader>y', '"+yy', { desc = 'Copy line to clipboard' })
map('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })
