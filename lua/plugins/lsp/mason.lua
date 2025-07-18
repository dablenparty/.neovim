---@type vim.lsp.Config[]
local servers = {
  basedpyright = {},
  bashls = { filetypes = { 'sh', 'zsh' } },
  dockerls = {},
  docker_compose_language_service = {},
  lua_ls = {
    -- other keys
    -- cmd = {...},
    -- filetypes = { ...},
    -- capabilities = {},
    settings = {
      Lua = {
        diagnostics = {
          -- disable 'undefined global vim'
          -- see lazydev.nvim for a better fix
          globals = { 'vim' },
        },
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  marksman = {},
}

-- merge custom LSP opts with base configs
for server, conf in pairs(servers) do
  vim.lsp.config(server, conf)
end

return {
  'mason-org/mason-lspconfig.nvim',
  dependencies = {
    {
      'mason-org/mason.nvim',
      opts = {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗'
          }
        }
      }
    },
    'neovim/nvim-lspconfig',
    -- status indicator for LSP's
    { 'j-hui/fidget.nvim', opts = {} }
  },
  opts = {
    automatic_enable = {
      exclude = { 'rust_analyzer' },
    },
    ensure_installed = vim.tbl_keys(servers)
  },
}
