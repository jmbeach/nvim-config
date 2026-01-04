local copilot_enabled = true
local function copilot_chat_save()
  -- Save to a file with today's date and first 50 characters of the prompt
  local date = os.date '%Y-%m-%d'
  local prompt = table.concat(vim.fn.getline(2, '$'), ' ')
  local trimmed = prompt:match('^%s*(.-)%s*$'):sub(1, 50)
  local sanitized_prompt = trimmed:gsub('[^%w%s]', '_'):gsub('%s+', '_')
  if sanitized_prompt == '' then
    return
  end

  -- Get list of files and sort by modification time
  local dir = vim.fn.stdpath 'data' .. '/copilotchat_history'
  local files = vim.fn.globpath(dir, 'copilot_*', false, true)
  table.sort(files, function(a, b)
    return vim.fn.getftime(a) < vim.fn.getftime(b)
  end)

  -- Delete oldest file if there are already 100 files
  if #files >= 100 then
    vim.fn.delete(files[1])
  end

  local filename = string.format('copilot_%s_%s', date, sanitized_prompt)
  vim.cmd('CopilotChatSave ' .. filename)
end
local function copilot_chat_reset()
  copilot_chat_save()
  vim.cmd 'CopilotChatReset'
end
local function copliot_chat_history()
  local telescope = require 'telescope.builtin'
  local function copilot_history_on_select(prompt_bufnr)
    local selection = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
    require('telescope.actions').close(prompt_bufnr)
    vim.cmd 'CopilotChatOpen'
    vim.cmd('CopilotChatLoad ' .. selection.value:gsub('%.json$', ''))
    return true
  end
  telescope.find_files {
    prompt_title = 'Copilot Chat History',
    cwd = vim.fn.stdpath 'data' .. '/copilotchat_history',
    attach_mappings = function(_, map)
      map({ 'i', 'n' }, '<CR>', copilot_history_on_select)
      map({ 'i', 'n' }, '<C-y>', copilot_history_on_select)
      return true
    end,
  }
end
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
            vim.cmd 'Copilot disable'
          else
            vim.cmd 'Copilot enable'
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
    branch = 'main',
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
          -- do not quit with <C-c>
          insert = '<C-S-c>',
        },
        reset = {
          -- do not reset with <C-l>
          normal = '<C-S-r>',
          insert = '<C-S-r>',
        },
      },
      prompts = {
        Commit = {
          prompt = 'Write commit message for the change. Do not use commitizen convention; just use a general commit style. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',
          context = 'git:staged',
        },
        CommitCommitizen = {
          prompt = 'Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.',
          context = 'git:staged',
        },
        General = {
          system_prompt = 'You are a helpful AI assistant. Your goal is to provide accurate, concise, and informative responses to a wide range of user questions and requests. You should always strive to be friendly, polite, and understanding. If you are unsure how to answer a question, you should indicate that you do not have the information or that you are not able to help.',
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
        mode = { 'n', 'v' },
        desc = '[T]oggle Copilot Chat',
      },
    },
    config = function(_, opts)
      require('CopilotChat').setup(opts)
      vim.api.nvim_create_autocmd('BufLeave', {
        pattern = 'copilot-*',
        callback = function()
          copilot_chat_save()
        end,
      })
      vim.keymap.set('n', '<Leader>Cr', copilot_chat_reset, { desc = '[C]opilot [r]eset' })
      vim.keymap.set({ 'n', 'v' }, '<Leader>CH', copliot_chat_history, { desc = '[C]opilot [H]istory' })
      vim.keymap.set('n', '<Leader>Cc', '<cmd>CopilotChatCommit<CR>', { desc = '[C]opilot [c]ommit' })
      vim.keymap.set('n', '<Leader>CC', '<cmd>CopilotChatCommitCommitizen<CR>', { desc = '[C]opilot [C]ommitizen' })
    end,
  },
}
