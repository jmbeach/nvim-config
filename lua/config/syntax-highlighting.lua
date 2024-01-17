local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- Have to manaully copy files from https://github.com/Tudyx/tree-sitter-log/tree/main/queries
-- to ~/.local/share/nvim/lazy/nvim-treesitter/queries/log
parser_config.log = {
  install_info = {
    url = "https://github.com/Tudyx/tree-sitter-log.git", -- local path or git repo
    files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "main", -- default branch in case of git repo if different from master
    generate_requires_npm = false,
    requires_generate_from_grammar = false,
  },
  filetype = "log",
}
