---@type table<string, { name: string, config: vim.lsp.Config }>
local lsp_pkgs = {
  basedpyright = {},
  ['bash-language-server'] = {
    name = 'bashls',
    config = { filetypes = { 'bash', 'sh', 'zsh' } },
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
      },
    },
  },
  marksman = {},
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
  local conform_formatters = require('conform').list_all_formatters()
  local pkgs_to_install = vim.tbl_keys(lsp_pkgs)
  for _, fmt in ipairs(conform_formatters) do
    local pkg = fmt.name
    if fmt.available then
      vim.notify(string.format('%s is already available', pkg), vim.log.levels.INFO, { title = 'mason.nvim' })
    else
      table.insert(pkgs_to_install, pkg)
    end
  end

  local registry = require 'mason-registry'
  registry.refresh(function()
    for _, pkg_name in ipairs(pkgs_to_install) do
      if not registry.has_package(pkg_name) then
        vim.notify(string.format('%s not found in registry.', pkg_name), vim.log.levels.ERROR)
        goto continue
      end

      local pkg = registry.get_package(pkg_name)
      if pkg:is_installed() then
        vim.notify(string.format('%s is already installed.', pkg_name), vim.log.levels.INFO, { title = 'mason.nvim' })
        goto continue
      end

      -- As best as I can tell, this checks if the package and installer specs are valid
      if not pkg:is_installable() then
        vim.notify(string.format('%s is not installable.', pkg_name), vim.log.levels.ERROR, { title = 'mason.nvim' })
      end

      vim.notify('Installing ' .. pkg_name, vim.log.levels.INFO, { title = 'mason.nvim' })
      pkg:install({}, function(success, payload)
        if not success then
          -- payload is an error
          vim.notify(string.format('Failed to install %s\n%s', pkg_name, vim.inspect(payload)), vim.log.levels.ERROR, { title = 'mason.nvim' })
        end
      end)
      ::continue::
    end
  end)
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
