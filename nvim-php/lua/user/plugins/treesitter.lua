


require('ts_context_commentstring').setup({})

vim.g.skip_ts_context_commentstring_module = true

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'arduino',
    'bash',
    'comment',
    'css',
    'diff',
    'dockerfile',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'go',
    'html',
    'http',
    'ini',
    'javascript',
    'json',
    'jsonc',
    'make',
    'markdown',
    'passwd',
    'php',
    'phpdoc',
    'python',
    'regex',
    'ruby',
    'rust',
    'sql',
    'svelte',
    'typescript',
    'vue',
    'xml',
    'yaml',
    'lua',
    'vim',
    'vimdoc',
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "yaml" }
  },
})
