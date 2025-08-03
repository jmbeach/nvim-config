function _G.log(x)
  print(vim.inspect(x))
end

function StringStartsWith(str, start)
  return str:sub(1, #start) == start
end
