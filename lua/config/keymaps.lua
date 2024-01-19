-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remap ctrl + / to run gcc in normal mode
vim.api.nvim_set_keymap("n", "<C-/>", ':execute "normal gcc"<CR>', { noremap = true, silent = true })
