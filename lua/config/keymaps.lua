-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local neogit = require("neogit")
local util_vim_buffer = require("util.vim.buffer")

local is_mac = vim.loop.os_uname().sysname == "Darwin"
local is_tmux = os.getenv("TMUX") ~= nil

local map = vim.keymap.set

-- Keep cursor centered when paging up and down
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })

-- Add a mapping to make alt + / open and hide the terminal
local Util = require("lazyvim.util")
local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end
map("n", "<M-/>", lazyterm, { desc = "Terminal (root dir)" })
map("t", "<M-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- Fix some screwy stuff on mac in tmux
if is_mac and is_tmux then
  -- Ctrl + - seems to be mapped to ctrl + _
  -- Overriding that to go back in jump list instead of opening terminal
  map("n", "<C-_>", "<C-o>", { desc = "Go back in jump list" })
  -- might be an alacritty thing. Ctrl + a is just getting interpretted as a
  map("n", "+", "<c-a>", { desc = "Increment number" })
  map("v", "g+", "g<c-a>", { desc = "Increment numbers" })
end

-- Map leader f p to print full file path
map("n", "<leader>fp", ":lua print(vim.api.nvim_buf_get_name(0))<cr>", { desc = "Print full file path" })

-- copy / paste to clipboard
map("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
map("n", "<leader>y", '"+yy', { desc = "Copy line to clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- toggle completion
map(
  "n",
  "<leader>ct",
  ":lua require('cmp').setup { enabled = not require('cmp').config.enabled }<CR>",
  { desc = "Toggle completion" }
)

-- make multiline string searchable
map("n", "<leader>sx", ":%s/\\n/\\\\n/g<cr>:%s/\\s\\s\\+/\\\\s\\\\+/g<cr>", { desc = "Make searchable" })

-- move word when broken up by key like "-"
map("n", "<M-w>", "/[_A-Z-]\\|\\><cr>", { desc = "Move word with seperators" })

-- use leader + g + d to open/close diff view
local diffview_toggle = function()
  local lib = require("diffview.lib")
  local view = lib.get_current_view()
  if view then
    -- Current tabpage is a Diffview; close it
    vim.cmd.DiffviewClose()
  else
    -- No open Diffview exists: open a new one
    vim.cmd.DiffviewOpen()
  end
end
map("n", "<leader>gd", diffview_toggle, { desc = "Diffview Open" })

-- use leader g + b to toggle git blame
map("n", "<leader>gb", "<Cmd>GitBlameToggle<CR>", { desc = "Git Blame Toggle" })

-- use neogit instead of lazygit
map("n", "<leader>gg", neogit.open, { desc = "Neogit (root dir)" })

-- general
map("v", "/", util_vim_buffer.search_visually_selected_text, { desc = "Visual search" })
map("n", "<leader>xm", "<cmd>messages<cr>", { desc = "Messages" })

-- spectre
map("n", "<leader>sR", function()
  require("spectre").open()
end, { desc = "Replace in Files (Spectre)" })

-- telescope
map("n", "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "Resume" })
map(
  "n",
  "<leader>sC",
  ":lua require('telescope').extensions.neoclip.default()<cr>",
  { desc = "Search Clipboard history" }
)

-- close all other buffers with <leader>bX
map("n", "<leader>bX", util_vim_buffer.close_all_but_open_buffer, { desc = "Close all but open" })
