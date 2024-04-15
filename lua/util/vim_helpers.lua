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

return M
