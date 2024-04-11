-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local neogit = require("neogit")
local harpoon = require("harpoon")

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

-- copy / paste to clipboard
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Copy line to clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- toggle completion
vim.keymap.set(
  "n",
  "<leader>ct",
  ":lua require('cmp').setup { enabled = not require('cmp').config.enabled }<CR>",
  { desc = "Toggle completion" }
)

-- make multiline string searchable
vim.keymap.set("n", "<leader>sx", ":%s/\\n/\\\\n/g<cr>:%s/\\s\\s\\+/\\\\s\\\\+/g<cr>", { desc = "Make searchable" })

-- move word when broken up by key like "-"
vim.keymap.set("n", "<M-w>", "/[_A-Z-]\\|\\><cr>", { desc = "Move word with seperators" })

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
vim.keymap.set("n", "<leader>gd", diffview_toggle, { desc = "Diffview Open" })

-- use leader g + b to toggle git blame
vim.keymap.set("n", "<leader>gb", "<Cmd>GitBlameToggle<CR>", { desc = "Git Blame Toggle" })

-- use neogit instead of lazygit
vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Neogit (root dir)" })

local get_harpoon_function = function(index)
  return function()
    harpoon:list():select(index)
  end
end
-- harpoon keybindings
vim.keymap.set("n", "<leader>1", get_harpoon_function(1), { desc = "Open harpoon window 1" })
vim.keymap.set("n", "<leader>2", get_harpoon_function(2), { desc = "Open harpoon window 2" })
vim.keymap.set("n", "<leader>3", get_harpoon_function(3), { desc = "Open harpoon window 3" })
vim.keymap.set("n", "<leader>4", get_harpoon_function(4), { desc = "Open harpoon window 4" })
vim.keymap.set("n", "<leader>5", get_harpoon_function(5), { desc = "Open harpoon window 5" })
vim.keymap.set("n", "<leader>H", function()
  harpoon:list():add()
  vim.notify("󰆤 File Harpooned 󰆤", vim.log.levels.INFO, { title = "Harpoon", icon = "󰯇" })
end, { desc = "Harpoon File" })
vim.keymap.set("n", "<leader>h", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Open harpoon window" })

-- setup telescope live grep args
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>/", telescope.extensions.live_grep_args.live_grep_args, { desc = "Find in Files" })
vim.keymap.set("v", "<leader>/", telescope_builtin.grep_string, { desc = "Find Selection in Files" })

-- Open oil on leader + e
vim.keymap.set("n", "<leader>e", require("oil").toggle_float, { desc = "Open file explorer" })
