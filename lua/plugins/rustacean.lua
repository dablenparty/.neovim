return {
  'mrcjkb/rustaceanvim',
  version = '>=6',
  lazy = false, -- this plugin handles laziness itself
  init = function()
    ---@module 'rustaceanvim'
    ---@type rustaceanvim.Opts
    vim.g.rustaceanvim = {
      ---@type rustaceanvim.lsp.ClientOpts
      server = {
        on_attach = function(_, bufnr)
          local set_key = function(mode, lhs, rhs, desc)
            local opts = { buffer = bufnr, silent = true, desc = desc }
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          -- overwrite LSP code actions and hover menu
          -- enable in visual and select modes for grouped actions
          set_key({ 'n', 'x' }, '<leader>ca', '<cmd>RustLsp codeAction<CR>', '[C]ode [A]ction')
          set_key('n', 'K', '<cmd>RustLsp hover actions<CR>', 'Hover Menu')
          set_key('x', 'K', '<cmd>RustLsp hover range<CR>', 'Hover Menu')

          -- useful diagnostic binds
          set_key('n', '<leader>dx', '<cmd>RustLsp renderDiagnostic current<CR>', 'Render [D]iagnostic')
          set_key('n', '<leader>dX', '<cmd>RustLsp renderDiagnostic cycle<CR>', 'Render Next [D]iagnostic')
          set_key('n', '<leader>de', '<cmd>RustLsp explainError current<CR>', 'E[x]plain [E]rror on line')
          set_key('n', '<leader>dE', '<cmd>RustLsp explainError cycle<CR>', 'E[x]plain Next [E]rror')
          set_key('n', '<leader>dr', '<cmd>RustLsp relatedDiagnostics<CR>', '[R]elated Diagnostics')

          -- testing binds
          set_key('n', '<leader>tt', '<cmd>RustLsp! testables<CR>', 'Re-run last testable')
          set_key('n', '<leader>tT', '<cmd>RustLsp testables<CR>', 'Show testables')

          -- misc
          set_key('n', 'gx', '<cmd>RustLsp openDocs<CR>', 'Open docs.rs for the symbol under the cursor.')
        end,
      },
      tools = {
        -- required to show test results as diagnostics (kinda buggy atm)
        test_executor = 'background',
      },
    }
  end,
}
