return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      -- `AppleInterfaceStyle` is only set (to "Dark") when macOS is in dark mode
      local style = vim.fn.system { 'defaults', 'read', '-g', 'AppleInterfaceStyle' }
      local is_dark = vim.v.shell_error == 0 and style:match 'Dark' ~= nil
      vim.cmd.colorscheme(is_dark and 'catppuccin-frappe' or 'catppuccin-latte')
    end,
  },
}
