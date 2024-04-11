-- notify needs background color because of using transparency plugin
require("notify").setup({
  background_colour = "#000000",
})

-- Have to call setup for scrollview (scrollbar) to work
require("scrollview").setup()
