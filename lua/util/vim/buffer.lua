local util_tbl = require("util.tbl")
local M = {}
function M.get_visually_selected_text()
  local _, start_line, start_col, _ = unpack(vim.fn.getpos("v"))
  local _, end_line, end_col, _ = unpack(vim.fn.getpos("."))
  if end_line - start_line > 0 then
    return ""
  end
  return vim.api.nvim_get_current_line():sub(start_col, end_col)
end

function M.search_visually_selected_text()
  local text = M.get_visually_selected_text()
  if text == "" then
    return
  end
  vim.api.nvim_input("<esc>/" .. text .. "<cr>")
end

function M.list_open_buffers()
  local tab = vim.api.nvim_get_current_tabpage()
  local windows = vim.api.nvim_tabpage_list_wins(tab)
  local result = {}
  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    table.insert(result, buf)
  end
  return result
end

function M.close_all_but_open_buffer()
  local active = M.list_open_buffers()
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    if not util_tbl.has_value(active, buf) then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end
return M
