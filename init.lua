-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
dofile(vim.fn.stdpath("config") .. "/lua/config/syntax-highlighting.lua")
