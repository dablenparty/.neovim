--- This is a convenience command for opening Neogit and setting `q` to quit from the status pane.
--- It is mean to be used externally, i.e. by opening neovim with `nvim +NeogitStandalone`
vim.api.nvim_create_user_command('NeogitStandalone', function(_)
  require('neogit').open { kind = 'replace' }
  local neogit_bufnr = vim.api.nvim_get_current_buf()
  vim.keymap.set('n', 'q', '<cmd>quit<cr>', { buffer = neogit_bufnr, desc = 'Quit', nowait = true })
end, { desc = 'Open Neogit as a Standalone Buffer, like :Man!' })

return {
  'NeogitOrg/neogit',
  cmd = {
    'Neogit',
    'NeogitCommit',
    'NeogitLogCurrent',
    'NeogitResetState',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- diffs
    'sindrets/diffview.nvim',
    -- picker
    'folke/snacks.nvim',
  },
  keys = {
    {
      '<leader>gn',
      function()
        require('neogit').open()
      end,
      mode = 'n',
      desc = 'Open [N]eogit',
    },
    {
      '<leader>gl',
      function()
        require('neogit').open { 'log' }
      end,
      mode = 'n',
      desc = 'Open Neogit [L]og',
    },
  },
  opts = {
    kind = 'floating',
    graph_style = 'unicode',
    process_spinner = true,
    mappings = {
      popup = {
        ['l'] = false,
        ['L'] = 'LogPopup',
      },
      status = {
        ['<space>'] = 'Toggle',
      },
    },
  },
}
