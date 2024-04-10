-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "text", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
    vim.opt_local.linebreak = true
  end,
})

local function is_neogit_status_open()
  local tabs = vim.api.nvim_list_tabpages()
  for _, tabpage_id in ipairs(tabs) do
    local windows = vim.api.nvim_tabpage_list_wins(tabpage_id)
    for _, window_id in ipairs(windows) do
      local bufnr = vim.api.nvim_win_get_buf(window_id)
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if string.match(bufname, "NeogitStatus") then
        return true
      end
    end
  end
  return false
end

function GitFetchUpstream(on_complete)
  local notification = require("neogit.lib.notification")
  local Job = require("plenary.job")
  local message = notification.info("Running Git Fetch")
  local job = Job:new({
    command = "git",
    args = { "fetch" },
    on_exit = function()
      on_complete()
      if message then
        message:delete()
      end
    end,
  })
  job:start()
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if is_neogit_status_open() then
      local neogit = require("neogit")
      GitFetchUpstream(function()
        neogit.refresh_manually()
      end)
    end
  end,
})
