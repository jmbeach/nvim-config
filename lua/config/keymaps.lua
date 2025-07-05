local map = vim.keymap.set

local is_mac = vim.loop.os_uname().sysname == 'Darwin'
local is_tmux = os.getenv 'TMUX' ~= nil

-- see messages
local function show_messages_in_buffer()
  vim.cmd 'belowright split'
  vim.cmd 'enew'
  vim.bo.buftype = 'nofile'
  vim.cmd "put =execute('messages')"
end
map('n', '<leader>xm', show_messages_in_buffer, { desc = 'Messages' })

-- copy / paste to clipboard
map('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })
map('n', '<leader>y', '"+yy', { desc = 'Copy line to clipboard' })
map('n', '<leader>p', '"+p', { desc = 'Paste from clipboard' })
map('v', '<leader>d', '"+d', { desc = 'Delete and yank to clipboard' })

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
map('n', '<leader>bd', '<cmd>bp|bd #<cr>', { desc = 'Buffer [d]elete' })

local function delete_all_but_open_buffers()
  local bufnrs = vim.api.nvim_list_bufs()
  for _, bufnr in ipairs(bufnrs) do
    if bufnr ~= vim.api.nvim_get_current_buf() then
      vim.api.nvim_buf_delete(bufnr, { force = false })
    end
  end
end
map('n', '<leader>bx', delete_all_but_open_buffers, { desc = 'Buffer e[x]it all but current' })

-- map leader tab tab to next tab
map('n', '<leader><tab><tab>', '<cmd>tabnext<cr>', { desc = '<Tab> [t]o next' })
map('n', '<leader><tab>x', '<cmd>tabclose<cr>', { desc = '<Tab> E[x]it' })
map('n', '<leader><tab>n', '<cmd>tabnew<cr>', { desc = '<Tab> [N]ew' })
map('n', '<tab><tab>', '<cmd>tabnext<cr>', { desc = '<Tab> [t]o next' })
map('n', '<tab>x', '<cmd>tabclose<cr>', { desc = '<Tab> E[x]it' })
map('n', '<tab>n', '<cmd>tabnew<cr>', { desc = '<Tab> [N]ew' })

-- Map leader u d to diff this
map('n', '<leader>ud', '<cmd>windo diffthis<cr>', { desc = '[D]iff this' })
map('n', '<leader>uD', '<cmd>windo diffoff<cr>', { desc = '[D]iff off' })

-- Map leader U to undo tree
map('n', '<leader>U', '<cmd>UndotreeToggle<cr>', { desc = 'Undo tree' })

map('n', '<C-w>z', '<C-w>_<C-w>|', { desc = '[W]indow [Z]oom' })
