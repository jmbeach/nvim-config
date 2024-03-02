return {
  -- Disable completion in text files
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.enabled = vim.bo.filetype ~= "text"
    end,
  },
  -- Adds multi-line cursor
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  -- Get grep args with telescope
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  -- Guess indentation for file
  {
    "tpope/vim-sleuth",
  },
}
