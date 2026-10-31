return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      -- `AppleInterfaceStyle` is only set (to "Dark") when macOS is in dark mode
      -- Other platforms always use the dark flavor
      local is_dark = true
      if vim.fn.has 'mac' == 1 then
        local style = vim.fn.system { 'defaults', 'read', '-g', 'AppleInterfaceStyle' }
        is_dark = vim.v.shell_error == 0 and style:match 'Dark' ~= nil
      end
      vim.cmd.colorscheme(is_dark and 'catppuccin-frappe' or 'catppuccin-latte')
    end,
  },
}
