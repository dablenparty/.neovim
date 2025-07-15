return {
  'folke/trouble.nvim',
  opts = {},
  cmd = { 'Trouble' },
  keys = {
    {
      '<leader>dt',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer [D]iagnostics ([T]rouble)',
    },
    {
      '<leader>dT',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = '[D]iagnostics ([T]rouble)',
    },
    {
      '<leader>dL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = '[L]ocation List (Trouble)',
    },
    {
      '<leader>dQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = '[Q]uickfix List (Trouble)',
    },
    {
      '[[',
      function()
        if require('trouble').is_open() then
          require('trouble').prev { skip_groups = true, jump = true }
          vim.diagnostic.open_float()
        elseif vim.diagnostic.is_enabled() and vim.diagnostic.get_prev() ~= nil then
          vim.diagnostic.jump { count = -1, float = true }
        else
          local ok, err = pcall(vim.cmd.cprev)
          if ok then
            return
          end
          -- wrap to end on "no more items" error
          if string.find(err, 'E553') then
            vim.cmd [[clast]]
          else
            Snacks.notify.warn(err)
          end
        end
      end,
      desc = 'Previous Trouble/[Q]uickfix Item',
    },
    {
      ']]',
      function()
        if require('trouble').is_open() then
          require('trouble').next { skip_groups = true, jump = true }
          vim.diagnostic.open_float()
        elseif vim.diagnostic.is_enabled() and vim.diagnostic.get_next() ~= nil then
          vim.diagnostic.jump { count = 1, float = true }
        else
          local ok, err = pcall(vim.cmd.cnext)
          if ok then
            return
          end
          -- wrap to start on "no more items" error
          if string.find(err, 'E553') then
            vim.cmd [[cfirst]]
          else
            Snacks.notify.warn(err)
          end
        end
      end,
      desc = 'Next Trouble/[Q]uickfix Item',
    },
  },
}
