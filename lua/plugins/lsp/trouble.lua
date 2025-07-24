if vim.g.have_nerd_font then
  local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
  local diagnostic_signs = {}
  for type, icon in pairs(signs) do
    diagnostic_signs[vim.diagnostic.severity[type]] = icon
  end
  vim.diagnostic.config { signs = { text = diagnostic_signs } }
end

-- enable inline diagnostics
vim.diagnostic.config { virtual_text = true }

return {
  'folke/trouble.nvim',
  opts = {},
  cmd = { 'Trouble' },
  event = { 'LspAttach' },
  keys = {
    {
      '<leader>td',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer [D]iagnostics',
    },
    {
      '<leader>tD',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = '[D]iagnostics',
    },
    {
      '<leader>ts',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = '[S]ymbols',
    },
    {
      '<leader>tl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = '[L]SP Definitions / references / ...',
    },
    {
      '<leader>tL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = '[L]ocation List',
    },
    {
      '<leader>tQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = '[Q]uickfix List',
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
