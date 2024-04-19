-- bootstrap lazy.nvim, LazyVim and your plugins
local this_dir = vim.fn.stdpath("config")
package.path = package.path .. ";" .. this_dir .. "/lua"

require("config.lazy")
require("util.init")
dofile(this_dir .. "/lua/config/coding.lua")
dofile(this_dir .. "/lua/config/ui.lua")
dofile(this_dir .. "/lua/config/syntax-highlighting.lua")
dofile(this_dir .. "/lua/config/file-associations.lua")
dofile(this_dir .. "/lua/config/writing.lua")
dofile(this_dir .. "/../private-nvim/init.lua")
