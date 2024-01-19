return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- add monokai
  { "tanvirtin/monokai.nvim" },

  -- add darcula
  { "doums/darcula" },

  -- Configure LazyVim to load darcula
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "darcula",
    },
  },
}
