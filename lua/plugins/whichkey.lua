return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    -- Document existing key chains
    local wk = require 'which-key'
    wk.add { '<leader><Tab>', group = '[<Tab>]' }
    wk.add { '<leader>b', group = '[B]uffer' }
    wk.add { '<leader>c', group = '[C]ode' }
    wk.add { '<leader>d', group = '[D]ocument' }
    wk.add { '<leader>f', group = '[F]ile' }
    wk.add { '<leader>g', group = '[G]it' }
    wk.add { '<leader>r', group = '[R]ename' }
    wk.add { '<leader>s', group = '[S]earch' }
    wk.add { '<leader>t', group = '[T]oggle' }
    wk.add { '<leader>u', group = '[U]i' }
    wk.add { '<leader>w', group = '[W]orkspace' }
    wk.add { '<leader>x', group = 'Diagnosti[x]' }
  end,
}
