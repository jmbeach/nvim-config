local M = {}
function M.has_value(tbl, val)
  for _, entry in ipairs(tbl) do
    if entry == val then
      return true
    end
  end
  return false
end
return M
