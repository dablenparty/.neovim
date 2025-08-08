return {
  'NeogitOrg/neogit',
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
