return {
  'mrjones2014/legendary.nvim',
  -- since legendary.nvim handles all your keymaps/commands,
  -- its recommended to load legendary.nvim before other plugins
  priority = 10000,
  lazy = false,
  opts = {
    extensions = { lazy_nvim = true },
    keymaps = {
      {
        '<leader>lz',
        ':Lazy',
        description = '[L]a[z]y Plugin Manager',
      },
    },
    autocmds = {
      {
        name = 'main-highlight-yank',
        clear = true,
        {
          'TextYankPost',
          function(event)
            vim.hl.on_yank { event = event }
          end,
          description = 'Highlight when yanking (copying) text',
        },
      },
      {
        name = 'main-lsp',
        clear = true,
        {
          'LspAttach',
          function(event)
            -- TODO: extract all of these to legendary autocmd specs

            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
              local highlight_augroup = vim.api.nvim_create_augroup('main-lsp-highlight', { clear = false })
              vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('main-lsp-detach', { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds { group = 'main-lsp-highlight', buffer = event2.buf }
                end,
              })
            end

            -- The following code creates a keymap to toggle inlay hints in your
            -- code, if the language server you are using supports them
            if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              Snacks.toggle.inlay_hints():map '<leader>uh'
            end

            vim.api.nvim_create_autocmd({ 'BufEnter' }, {
              pattern = { 'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml' },
              group = vim.api.nvim_create_augroup('docker-compose-lsp-attach', { clear = true }),
              command = 'set filetype=yaml.docker-compose',
            })

            -- Change diagnostic symbols in the sign column (gutter)
            if vim.g.have_nerd_font then
              local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
              local diagnostic_signs = {}
              for type, icon in pairs(signs) do
                diagnostic_signs[vim.diagnostic.severity[type]] = icon
              end
              vim.diagnostic.config { signs = { text = diagnostic_signs } }
            end
          end,
          description = 'Enable misc LSP features',
        },
      },
    },
  },
}
