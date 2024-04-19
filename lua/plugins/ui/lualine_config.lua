local is_shown = true

local toggle = function()
  is_shown = not is_shown
  require("lualine").hide({ unhide = is_shown })
end
return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "RRethy/nvim-base16" },
  },
  event = "VeryLazy",
  init = function()
    -- set to visible. Something is causing it to get hidden
    require("lualine").hide({ unhide = true })
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = require("lazyvim.config").icons

    -- disable status line in favor of tabline
    vim.o.laststatus = 0

    local bar_config = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },

      lualine_c = {
        LazyVim.lualine.root_dir(),
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        {
          "buffers",
          buffers_color = {
            active = "lualine_a_insert",
            inactive = "lualine_c_inactive",
          },
          symbols = {
            alternate_file = " ",
          },
        },
      },
      lualine_x = {
        -- stylua: ignore
        {
          function() return require("noice").api.status.command.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          color = LazyVim.ui.fg("Statement"),
        },
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = LazyVim.ui.fg("Constant"),
        },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = LazyVim.ui.fg("Debug"),
        },
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = LazyVim.ui.fg("Special"),
        },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      },
      lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        { "tabs" },
      },
    }
    return {
      options = {
        theme = "base16",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        section_separators = { left = "█", right = "█" },
        component_separators = { left = " | ", right = " | " },
      },
      sections = {},
      inactive_sections = {},
      tabline = bar_config,
      extensions = { "neo-tree", "lazy" },
    }
  end,
  keys = {
    { "<leader>uS", toggle, desc = "Toggle status line" },
  },
}
