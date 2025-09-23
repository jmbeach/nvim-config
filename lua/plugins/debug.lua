-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  cmd = 'LoadNvimDap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    -- show the value of variables
    'theHamsta/nvim-dap-virtual-text',
    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = '[D]ebug [T]oggle breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug Step [I]nto' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug Step [O]ver' })
    vim.keymap.set('n', '<leader>du', dap.step_out, { desc = '[D]ebug Step O[u]t' })
    vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = '[D]ebug [R]epl' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = '[D]ebug Run [L]ast' })
    vim.keymap.set('n', '<leader>dq', function()
      dap.terminate()
      require('dapui').close()
    end, { desc = '[D]ebug [Q]uit' })
    vim.keymap.set('n', '<leader>db', dap.list_breakpoints, { desc = '[D]ebug List [B]reakpoints' })
    vim.keymap.set('n', '<leader>de', function()
      dap.set_exception_breakpoints { 'all' }
    end, { desc = '[D]ebug Set [E]xception Breakpoints' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open

    -- Install lang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }
    local getPythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end
    dap.configurations = {
      python = {
        {
          type = 'python',
          request = 'launch',
          console = 'integratedTerminal',
          name = 'Launch file',
          program = '${file}',
          pythonPath = getPythonPath,
        },
        {
          type = 'python',
          request = 'launch',
          console = 'integratedTerminal',
          name = 'Launch module',
          module = function()
            return vim.fn.input 'Module name: '
          end,
          pythonPath = getPythonPath,
          args = function()
            local arg = vim.fn.input 'Args: '
            return { arg }
          end,
        },
      },
    }
  end,
}
