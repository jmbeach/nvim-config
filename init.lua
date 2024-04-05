-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
dofile(vim.fn.stdpath("config") .. "/lua/config/coding.lua")
dofile(vim.fn.stdpath("config") .. "/lua/config/ui.lua")
dofile(vim.fn.stdpath("config") .. "/lua/config/syntax-highlighting.lua")
dofile(vim.fn.stdpath("config") .. "/lua/config/file-associations.lua")
dofile(vim.fn.stdpath("config") .. "/lua/config/writing.lua")
dofile(vim.fn.stdpath("config") .. "/../private-nvim/init.lua")
