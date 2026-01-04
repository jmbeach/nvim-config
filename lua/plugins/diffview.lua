return {
  'sindrets/diffview.nvim',
  lazy = false,
  opts = function(_, opts)
    opts.keymaps = {
      view = {},
      file_panel = {},
    }
  end,
  keys = function(_, keys)
    return vim.list_extend({
      { '<leader>gd', '<Cmd>DiffviewOpen<CR>', { desc = 'Open diffview' } },
      { '<leader>gh', '<Cmd>DiffviewFileHistory<CR>', { desc = '[G]it [H]istory for File' } },
    }, keys)
  end,
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'fugitive',
      group = vim.api.nvim_create_augroup('FugitiveBC', { clear = true }),
      callback = function(args)
        -- This function will be called by the keymap.
        local function open_conflict_in_bcompare()
          -- 1. Get the line under the cursor.
          local line = vim.fn.getline '.'

          -- 2. Extract the file path from lines indicating a merge conflict (e.g., "U file/path.txt").
          local file_path = line:match '^%s*U%s+(.+)$'

          if not file_path then
            vim.notify('Cursor is not on a merge conflict line (U)', vim.log.levels.WARN)
            return
          end

          -- 3. Find the root of the current git repository.
          local git_root = vim.fn.trim(vim.fn.system 'git rev-parse --show-toplevel')
          if vim.v.shell_error ~= 0 then
            vim.notify('Failed to find git repository root.', vim.log.levels.ERROR)
            return
          end

          local parts = StringSplit(file_path, '.')
          local ext = parts[#parts]

          -- # NEW: Construct meaningful temporary filenames
          local base_file = string.format('%s_BASE.%s', vim.fn.tempname(), ext)
          local local_file = string.format('%s_LOCAL.%s', vim.fn.tempname(), ext)
          local remote_file = string.format('%s_REMOTE.%s', vim.fn.tempname(), ext)

          -- 5. Use 'git show' to write the content of each stage into the temp files.
          vim.fn.system(string.format('git show :1:%s > %s', file_path, base_file))
          vim.fn.system(string.format('git show :2:%s > %s', file_path, local_file))
          vim.fn.system(string.format('git show :3:%s > %s', file_path, remote_file))

          -- 6. Construct the full command to launch Beyond Compare for a 3-way merge.
          --    Format: bcompare <left> <right> <center> <output>
          local merged_target = git_root .. '/' .. file_path
          local cmd = string.format('bcompare %s %s %s %s', local_file, remote_file, base_file, merged_target)

          -- 7. Run the command asynchronously so it doesn't block Neovim.
          vim.notify('Opening in Beyond Compare...', vim.log.levels.INFO)
          vim.fn.jobstart(cmd)
        end

        -- 8. Create the buffer-local keymap.
        vim.keymap.set('n', '<leader>gB', open_conflict_in_bcompare, {
          buffer = args.buf, -- Apply only to the current fugitive buffer
          silent = true,
          desc = 'Fugitive: Open conflict in Beyond Compare',
        })
      end,
    })
  end,
}
