local map = vim.keymap.set

local is_mac = vim.loop.os_uname().sysname == 'Darwin'
local is_tmux = os.getenv 'TMUX' ~= nil

-- see messages
map('n', '<leader>xm', '<cmd>messages<cr>', { desc = 'Messages' })
map('n', '<leader>y', '"+yy', { desc = 'Copy line to clipboard' })

-- copy / paste to clipboard
map('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
map('n', '<leader>y', '"+yy', { desc = 'Copy line to clipboard' })
map('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })

-- Keep cursor centered when paging up and down
map('n', '<C-u>', '<C-u>zz', { desc = 'Half page up' })
map('n', '<C-d>', '<C-d>zz', { desc = 'Half page down' })

-- Map leader f p to print full file path
map('n', '<leader>fp', ':lua print(vim.api.nvim_buf_get_name(0))<cr>', { desc = 'Print full file path' })

-- H and L for next and previous buffers
map('n', '<S-l>', ':bn<cr>', { desc = 'Buffer next' })
map('n', '<S-h>', ':bN<cr>', { desc = 'Buffer prev' })

-- Fix some screwy stuff on mac in tmux
if is_mac and is_tmux then
  -- might be an alacritty thing. Ctrl + a is just getting interpretted as a
  map('n', '+', '<c-a>', { desc = 'Increment number' })
  map('v', 'g+', 'g<c-a>', { desc = 'Increment numbers' })
end

-- map leader b d to buffer delete
map('n', '<leader>bd', '<cmd>bd<cr>', { desc = 'Buffer [d]elete' })
map('n', '<leader>bx', '<cmd>%bd|e#<cr>', { desc = 'Buffer e[x]it all but current' })

-- map leader tab tab to next tab
map('n', '<leader><tab><tab>', '<cmd>tabnext<cr>', { desc = '<Tab> [t]o next' })
