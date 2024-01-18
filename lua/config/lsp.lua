require("mason-lspconfig").setup({
  ensure_installed = { "metals" },
})
require("lspconfig").metals.setup({})
