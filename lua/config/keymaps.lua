-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local neogit = require("neogit")
local harpoon = require("harpoon")
local oil = require("oil")
local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local scroll = require("neoscroll")
local vim_helpers = require("../util/vim_helpers")

-- Smooth scrolling on page up and down
local scroll_down = function()
  scroll.scroll(vim.wo.scroll, true, 350)
end
local scroll_up = function()
  scroll.scroll(-vim.wo.scroll, true, 350)
end
vim.keymap.set("n", "<C-u>", scroll_up, { desc = "Half page up" })
vim.keymap.set("n", "<C-d>", scroll_down, { desc = "Half page down" })

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
  -- might be an alacritty thing. Ctrl + a is just getting interpretted as a
  vim.keymap.set("n", "+", "<c-a>", { desc = "Increment number" })
  vim.keymap.set("v", "g+", "g<c-a>", { desc = "Increment numbers" })
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

-- general
vim.keymap.set("v", "/", vim_helpers.search_visually_selected_text, { desc = "Visual search" })

-- Open oil on leader + e
local open_oil = function()
  oil.open()
end
vim.keymap.set("n", "<leader>e", open_oil, { desc = "Open file explorer" })

vim.keymap.set("n", "<leader>xm", "<cmd>messages<cr>", { desc = "Messages" })

vim.keymap.set("n", "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "Resume" })
vim.keymap.set("n", "<leader>sR", function()
  require("spectre").open()
end, { desc = "Replace in Files (Spectre)" })
