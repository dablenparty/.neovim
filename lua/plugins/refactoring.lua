return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  -- this plugin has a HEAVYY startup
  lazy = true,
  -- It supports more, but these are the ones I use
  ft = {
    'typescript',
    'typescriptreact',
    'javascript',
    'javascriptreact',
    'lua',
    'c',
    'go',
    'python',
    'java',
  },
  opts = {},
  config = function()
    -- NOTE: do not replace this with a `keys` table in the plugin spec
    -- See crates.lua for more

    vim.keymap.set('x', '<leader>rf', function()
      require('refactoring').refactor 'Extract Function'
    end, { desc = 'Extract [F]unction' })
    vim.keymap.set('x', '<leader>rF', function()
      require('refactoring').refactor 'Extract Function To File'
    end, { desc = 'Extract Function to [F]ile' })
    -- Extract function supports only visual mode
    vim.keymap.set('x', '<leader>rv', function()
      require('refactoring').refactor 'Extract Variable'
    end, { desc = 'Extract [V]ariable' })
    -- Extract variable supports only visual mode
    vim.keymap.set('n', '<leader>rI', function()
      require('refactoring').refactor 'Inline Function'
    end, { desc = '[I]nline  Function' })
    -- Inline func supports only normal
    vim.keymap.set({ 'n', 'x' }, '<leader>ri', function()
      require('refactoring').refactor 'Inline Variable'
    end, { desc = '[I]nline Variable' })
    -- Inline var supports both normal and visual mode

    vim.keymap.set('n', '<leader>rb', function()
      require('refactoring').refactor 'Extract Block'
    end, { desc = 'Extract [B]lock' })
    vim.keymap.set('n', '<leader>rB', function()
      require('refactoring').refactor 'Extract Block To File'
    end, { desc = 'Extract [B]lock to File' })
    -- Extract block supports only normal mode
  end,
}
