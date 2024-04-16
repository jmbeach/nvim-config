return {
  -- adds a scrollbar
  { "dstein64/nvim-scrollview" },
  -- makes background transparent
  { "xiyaowong/transparent.nvim" },
  -- harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup({})
    end,
  },
  {
    "akinsho/bufferline.nvim",
    disabled = true,
  },
}
