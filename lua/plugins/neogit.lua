return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - Diff integration

      -- Only one of these is needed, not both.
      'nvim-telescope/telescope.nvim', -- optional
      'ibhagwan/fzf-lua', -- optional
    },
    config = function()
      local neogit = require 'neogit'
      neogit.setup {}
      vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Neogit (root dir)' })
    end,
    opts = function(_, opts)
      opts.mappings = {
        commit_editor = {
          ['q'] = 'Close',
          ['<c-c><c-c>'] = 'Submit',
          ['<leader>A'] = 'Abort',
        },
        finder = {
          ['<cr>'] = 'Select',
          ['<c-y>'] = 'Select',
          ['<c-c>'] = 'Close',
          ['<esc>'] = 'Close',
          ['<c-n>'] = 'Next',
          ['<c-p>'] = 'Previous',
          ['<down>'] = 'Next',
          ['<up>'] = 'Previous',
          ['<tab>'] = 'MultiselectToggleNext',
          ['<s-tab>'] = 'MultiselectTogglePrevious',
          ['<c-j>'] = 'NOP',
        },
      }
      return opts
    end,
  },
}
