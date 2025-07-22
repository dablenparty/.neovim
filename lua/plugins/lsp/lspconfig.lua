return {
  { 'neovim/nvim-lspconfig' },
  {
    -- status indicator for LSP's
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {},
  },
}
