function _G.log(x)
  print(vim.inspect(x))
end

function StringStartsWith(str, start)
  return str:sub(1, #start) == start
end

function StringSplit(inputstr, sep)
  if sep == nil then
    sep = '%s+' -- Default to splitting by one or more whitespace characters
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end
  return t
end
