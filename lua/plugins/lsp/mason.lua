---@type table<string, { name: string, config: vim.lsp.Config }>
local lsp_pkgs = {
  ['bash-language-server'] = {
    name = 'bashls',
    config = { filetypes = { 'bash', 'sh', 'zsh' } },
  },
  ['docker-compose-language-service'] = { name = 'docker_compose_language_service' },
  ['dockerfile-language-server'] = { name = 'dockerls' },
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
  ['python-lsp-server'] = { name = 'pylsp' },
}

local lsps_to_enable = {}
-- merge custom LSP opts with base configs
for pkg, lsp in pairs(lsp_pkgs) do
  local lsp_name = lsp.name or pkg
  vim.lsp.config(lsp_name, lsp.config or {})
  table.insert(lsps_to_enable, lsp_name)
end

vim.lsp.enable(lsps_to_enable)

vim.api.nvim_create_user_command('MasonUpdateAllPkgs', function(args)
  local registry = require 'mason-registry'
  registry.refresh(function()
    ---@type Package[]
    local installed_pkgs = registry.get_installed_packages()
    if #installed_pkgs == 0 then
      vim.notify('No packages are installed.', vim.log.levels.WARN, { title = 'mason.nvim' })
    end
    for _, pkg in ipairs(installed_pkgs) do
      vim.notify('Updating ' .. pkg.name, vim.log.levels.INFO, { title = 'mason.nvim' })
      pkg:install({}, function(success, payload)
        if not success then
          -- payload is an error
          vim.notify(string.format('Failed to update %s\n%s', pkg.name, vim.inspect(payload)), vim.log.levels.ERROR, { title = 'mason.nvim' })
        end
      end)
    end
  end)

  if not args.bang then
    -- Open mason UI
    vim.cmd 'Mason'
  end
end, { desc = 'Update all installed packages', bang = true })

vim.api.nvim_create_user_command('MasonInstallAll', function(args)
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
        vim.notify(string.format('%s not found in registry.', pkg_name), vim.log.levels.ERROR, { title = 'mason.nvim' })
        goto continue
      end

      local pkg = registry.get_package(pkg_name)
      local lsp_executable = vim.tbl_keys(pkg.spec.bin)[1] or pkg.name
      if registry.is_installed(pkg.name) or vim.fn.executable(lsp_executable) == 1 then
        vim.notify(string.format('%s is installed externally.', pkg.name), vim.log.levels.INFO, { title = 'mason.nvim' })
        goto continue
      end

      -- As best as I can tell, this checks if the package and installer specs are valid
      if not pkg:is_installable() then
        vim.notify(string.format('%s is not installable.', pkg.name), vim.log.levels.ERROR, { title = 'mason.nvim' })
      end

      vim.notify('Installing ' .. pkg.name, vim.log.levels.INFO, { title = 'mason.nvim' })
      pkg:install({}, function(success, payload)
        if not success then
          -- payload is an error
          vim.notify(string.format('Failed to install %s\n%s', pkg.name, vim.inspect(payload)), vim.log.levels.ERROR, { title = 'mason.nvim' })
        end
      end)
      ::continue::
    end

    if not args.bang then
      -- open Mason UI
      vim.cmd 'Mason'
    end
  end)
end, { desc = 'Install all defined packages', bang = true })

return {
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
}
