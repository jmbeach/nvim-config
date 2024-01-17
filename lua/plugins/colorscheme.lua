return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  -- add monokai
  { "tanvirtin/monokai.nvim" },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai",
    },
  },
}
