local lsp_pkgs = {
  basedpyright = {},
  ['bash-language-server'] = {
    name = 'bashls',
    config = { filetypes = { 'bash', 'sh', 'zsh' } }
  },
  ['dockerfile-language-server'] = { name = 'dockerls' },
  ['docker-compose-language-service'] = { name = 'docker_compose_language_service' },
  ['lua-language-server'] = {
    name = 'lua_ls',
    config = {
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
      }
    }
  },
  marksman = {}
}

local lsps_to_enable = {}
-- merge custom LSP opts with base configs
for pkg, lsp in pairs(lsp_pkgs) do
  local lsp_name = lsp.name or pkg
  vim.lsp.config(lsp_name, lsp.config or {})
  table.insert(lsps_to_enable, lsp_name)
end

vim.lsp.enable(lsps_to_enable)

vim.api.nvim_create_user_command('MasonInstallAll', function()
  local mason_pkgs = vim.tbl_keys(lsp_pkgs)
  vim.cmd { cmd = 'MasonUpdate' }
  vim.cmd { cmd = 'MasonInstall', args = mason_pkgs }
end, { desc = 'Install all defined packages' })

return {
  {
    'neovim/nvim-lspconfig',
    -- status indicator for LSP's
    dependencies = { { 'j-hui/fidget.nvim', opts = {} } },
  },
  {
    'mason-org/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
}
