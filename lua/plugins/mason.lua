-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
-- defined here to be used by various functions below
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
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  marksman = {},
}

return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    -- mason itself (must be first)
    { 'williamboman/mason.nvim', opts = {} },

    -- neovim LSP config (no setup required)
    'neovim/nvim-lspconfig',

    -- manages & auto-updates any tools installed with mason
    {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      opts = function(_, opts)
        opts = opts or {}
        local formatters = { 'prettier', 'shfmt', 'stylua' }
        local linters = { 'hadolint', 'markdownlint-cli2', 'shellcheck' }

        local ensure_installed = vim.tbl_keys(servers)
        vim.list_extend(ensure_installed, formatters)
        vim.list_extend(ensure_installed, linters)
        opts.ensure_installed = ensure_installed

        return opts
      end,
    },
    -- Useful status update notifications for LSP.
    { 'j-hui/fidget.nvim', opts = {} },
  },
  opts = {
    automatic_enable = {
      -- handled by rustaceanvim
      exclude = { 'rust_analyzer' },
    },
    ensure_installed = {},
  },
}
