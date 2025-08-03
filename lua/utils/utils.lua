local M = {
  ui = {},
  nvim = {},
}

function M.ui.fg(name)
  ---@type {foreground?:number}?
  ---@diagnostic disable-next-line: deprecated
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  ---@diagnostic disable-next-line: undefined-field
  local fg = hl and (hl.fg or hl.foreground)
  return fg and { fg = string.format('#%06x', fg) } or nil
end

function M.nvim.is_buffer_shown(bufnr)
  local tabpages = vim.api.nvim_list_tabpages()
  for _, tabid in ipairs(tabpages) do
    local windows_in_tab = vim.api.nvim_tabpage_list_wins(tabid)
    for _, winid in ipairs(windows_in_tab) do
      local win_bufnr = vim.api.nvim_win_get_buf(winid)
      if vim.api.nvim_win_is_valid(winid) and win_bufnr == bufnr then
        return true
      end
    end
  end
  return false
end

return M
