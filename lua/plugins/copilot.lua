local copilot_enabled = true
return {
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-c>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
    lazy = false,
    keys = {
      {
        '<leader>tc',
        function()
          if copilot_enabled then
            vim.cmd 'Copilot enable'
          else
            vim.cmd 'Copilot disable'
          end
          copilot_enabled = not copilot_enabled
        end,
        mode = 'n',
        desc = 'Toggle Copilot',
      },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    lazy = false,
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
      mappings = {
        close = {
          normal = 'q',
        },
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      {
        '<leader>tC',
        function()
          require('CopilotChat').toggle()
        end,
        mode = 'n',
        desc = '[T]oggle Copilot Chat',
      },
    },
  },
}
