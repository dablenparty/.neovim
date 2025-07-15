return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
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
  opts = {
    show_success_message = true,
  },
  config = function(opts, _)
    opts = opts or {}
    require('refactoring').setup(opts)

    -- WARN: do not replace this with a `keys` table in the plugin spec
    -- See crates.lua for more

    -- NOTE: the Ex commands are preferred to the Lua API because they allow a live-preview of changes
    -- while the Lua API does not ATW.
    vim.keymap.set('x', '<leader>rf', ':Refactor extract ', { desc = 'Extract [F]unction' })
    vim.keymap.set('x', '<leader>rF', ':Refactor extract_to_file ', { desc = 'Extract Function to [F]ile' })
    vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ', { desc = 'Extract [V]ariable' })
    vim.keymap.set('n', '<leader>rI', ':Refactor inline_func ', { desc = '[I]nline  Function' })
    vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var', { desc = '[I]nline Variable' })
    vim.keymap.set('n', '<leader>rb', ':Refactor extract_block', { desc = 'Extract [B]lock' })
    vim.keymap.set('n', '<leader>rB', ':Refactor extract_block_to_file', { desc = 'Extract [B]lock to File' })

    -- Set `prefer_ex_cmd = false` to use builtin `vim.ui.input` (not working ATW)
    vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
      require('refactoring').select_refactor { prefer_ex_cmd = true }
    end, { desc = '[R]efactor He[r]e...' })
  end,
}
