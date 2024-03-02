-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keep cursor centered when paging up and down
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })

-- Add a mapping to make alt + / open and hide the terminal
local Util = require("lazyvim.util")
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
vim.keymap.set("n", "<M-/>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("t", "<M-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

local is_mac = vim.loop.os_uname().sysname == "Darwin"
local is_tmux = os.getenv("TMUX") ~= nil

-- Fix some screwy stuff on mac in tmux
if is_mac and is_tmux then
  -- Ctrl + - seems to be mapped to ctrl + _
  -- Overriding that to go back in jump list instead of opening terminal
  vim.keymap.set("n", "<C-_>", "<C-o>", { desc = "Go back in jump list" })
end

-- Map leader f p to print full file path
vim.keymap.set("n", "<leader>fp", ":lua print(vim.api.nvim_buf_get_name(0))<cr>", { desc = "Print full file path" })

-- setup telescope live grep args
vim.keymap.set("n", "<leader>/", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

-- copy / paste to clipboard
vim.keymap.set("v", "<leader>cc", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- toggle completion
vim.keymap.set(
  "n",
  "<leader>ct",
  ":lua require('cmp').setup { enabled = not require('cmp').config.enabled }<CR>",
  { desc = "Toggle completion" }
)
