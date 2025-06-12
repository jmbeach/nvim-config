return {
  {
    'mfussenegger/nvim-lint',
    cmd = 'LazyLint',
    ft = { 'groovy' },
    config = function()
      require('lint').linters_by_ft = {
        groovy = { 'npm-groovy-lint' },
      }
    end,
  },
}
