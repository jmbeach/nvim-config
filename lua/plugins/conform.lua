return { -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[C]ode [F]ormat',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 5000,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters = {
      shfmt = {
        prepend_args = { '-i', '4' },
      },
      sleek = {
        prepend_args = { '-i', '2' },
      },
    },
    formatters_by_ft = {
      html = { 'htmlbeautifier' },
      lua = { 'stylua' },
      yaml = { 'prettierd' },
      astro = { 'prettier' },
      javascript = { 'prettierd' },
      json = { 'jq' },
      svelte = { 'prettierd' },
      python = { 'autopep8' },
      terraform = { 'terraform_fmt' },
      sql = { 'sleek' },
      sh = {
        'shfmt',
      },
    },
  },
}
