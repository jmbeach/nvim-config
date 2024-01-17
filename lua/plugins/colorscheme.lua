return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- add monokai
  { "tanvirtin/monokai.nvim" },

  { "doums/darcula" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "darcula",
    },
  },
}
