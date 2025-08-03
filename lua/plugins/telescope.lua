local function search_manual_on_select(prompt_bufnr)
  local selection = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
  require('telescope.actions').close(prompt_bufnr)
  local path_to_file = vim.fn.getenv 'HOME' .. '/Documents/manuals/' .. selection.value
  vim.cmd('edit ' .. path_to_file)
  return true
end
local function search_manual()
  local telescope = require 'telescope.builtin'
  telescope.find_files {
    prompt_title = 'Search Manuals',
    cwd = vim.fn.getenv 'HOME' .. '/Documents/manuals',
    attach_mappings = function(_, map)
      map({ 'i', 'n' }, '<CR>', search_manual_on_select)
      map({ 'i', 'n' }, '<C-y>', search_manual_on_select)
      return true
    end,
  }
end
local function open_copilot_chat_actions()
  local actions = require 'CopilotChat.actions'
  require('CopilotChat.integrations.telescope').pick(actions.help_actions())
end
local function open_copilot_chat_prompts()
  local actions = require 'CopilotChat.actions'
  require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
end
return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'rafi/telescope-thesaurus.nvim' },
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },

    -- Get grep args with telescope
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
    },
  },
  config = function()
    local actions = require 'telescope.actions'
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    local find_files_no_ignore = function()
      local action_state = require 'telescope.actions.state'
      local line = action_state.get_current_line()
      require('telescope.builtin').find_files { no_ignore = true, default_text = line }
    end
    local find_files_with_hidden = function()
      local action_state = require 'telescope.actions.state'
      local line = action_state.get_current_line()
      require('telescope.builtin').find_files { hidden = true, no_ignore = true, default_text = line }
    end
    local function move_buffer_to_end()
      local action_state = require 'telescope.actions.state'
      local entry = action_state.get_selected_entry()
      vim.api.nvim_buf_delete(entry.bufnr, {})
      local new_buf_id = vim.api.nvim_create_buf(true, false)
      local prompt_bufnr = vim.api.nvim_get_current_buf()
      actions.close(prompt_bufnr)
      vim.cmd('buffer ' .. new_buf_id)
      vim.cmd('e ' .. entry.filename)
      local builtin = require 'telescope.builtin'
      builtin.buffers()
    end
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        mappings = {
          i = {
            ['<a-i>'] = find_files_no_ignore,
            ['<a-h>'] = find_files_with_hidden,
            ['<C-y>'] = actions.select_default,
          },
        },
      },
      pickers = {
        buffers = {
          layout_strategy = 'vertical',
          layout_config = { mirror = 'true', prompt_position = 'top', preview_cutoff = 0 },
          mappings = {
            n = {
              ['<c-d>'] = 'delete_buffer',
              ['<c-e>'] = move_buffer_to_end,
            },
            i = {
              ['<c-d>'] = 'delete_buffer',
              ['<c-e>'] = move_buffer_to_end,
            },
          },
        },
        find_files = {
          layout_strategy = 'vertical',
          layout_config = { mirror = 'true', prompt_position = 'top', preview_cutoff = 0 },
        },
        live_grep = {
          layout_strategy = 'vertical',
          layout_config = { mirror = 'true', prompt_position = 'top', preview_cutoff = 0 },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        live_grep_args = {
          layout_strategy = 'vertical',
          layout_config = { mirror = 'true', prompt_position = 'top', preview_cutoff = 0 },
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sc', builtin.command_history, { desc = '[S]earch [C]ommand History' })
    vim.keymap.set('n', '<leader>sH', builtin.search_history, { desc = '[S]earch Search [H]istory' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>st', '<cmd>Telescope thesaurus lookup<CR>', { desc = '[S]earch [T]hesaurus' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
    vim.keymap.set('n', '<Leader>sm', search_manual, { desc = '[S]earch [m]anual' })
    vim.keymap.set('n', '<leader>Ch', open_copilot_chat_actions, { desc = '[C]opilotChat - [H]elp actions' })
    vim.keymap.set('n', '<leader>Cp', open_copilot_chat_prompts, { desc = '[C]opilotChat - [P]rompts' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
