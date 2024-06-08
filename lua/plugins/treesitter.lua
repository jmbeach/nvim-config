return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'log' },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()

    -- Adds a parser for log files
    -- Have to manaully copy files from https://github.com/Tudyx/tree-sitter-log/tree/main/queries
    -- to ~/.local/share/nvim/lazy/nvim-treesitter/queries/log
    parser_config.log = {
      install_info = {
        url = 'https://github.com/Tudyx/tree-sitter-log.git', -- local path or git repo
        files = { 'src/parser.c' }, -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        branch = 'main', -- default branch in case of git repo if different from master
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
      filetype = 'log',
    }
  end,
}
