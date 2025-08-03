return {
  'nvim-pack/nvim-spectre',
  event = 'VeryLazy',
  keys = {
    { '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', desc = 'Toggle [S]pectre' },
  },
}
