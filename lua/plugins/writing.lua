return {
  { "junegunn/goyo.vim" },
  {
    "junegunn/limelight.vim",
    config = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoEnter",
        callback = function()
          vim.cmd("Limelight")
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "GoyoLeave",
        callback = function()
          vim.cmd("Limelight!")
        end,
      })
    end,
  },
}
