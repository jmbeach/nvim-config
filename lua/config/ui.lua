-- notify needs background color because of using transparency plugin
require("notify").setup({
  background_colour = "#000000",
})

-- Have to call setup for scrollview (scrollbar) to work
require("scrollview").setup()

-- setup telescope live grep args
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
