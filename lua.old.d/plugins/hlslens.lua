-- Better UI for search matches
return {
  'kevinhwang91/nvim-hlslens',
  event = 'BufEnter',
  config = function()
    require('hlslens').setup {
      calm_down = true,
      nearest_float_when = 'always',
    }

    -- run `:nohlsearch` and export results to quickfix
    vim.keymap.set({ 'n', 'x' }, '<Leader>L', function()
      vim.schedule(function()
        if require('hlslens').exportLastSearchToQuickfix() then
          vim.cmd 'cw'
        end
      end)
      return ':noh<CR>'
    end, { desc = 'Send [l]ast search to Quickfix', expr = true })

    ---@param lhs string
    ---@param rhs string
    ---@param desc string
    local set_key = function(lhs, rhs, desc)
      local opts = { noremap = true, silent = true, desc = desc }
      vim.keymap.set('n', lhs, rhs, opts)
    end

    set_key('n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], 'Goto next search result')
    set_key('N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], 'Goto previous search result')
    set_key('*', [[*<Cmd>lua require('hlslens').start()<CR>]], 'Search forward for nearest word')
    set_key('#', [[#<Cmd>lua require('hlslens').start()<CR>]], 'Search backwrad for the nearest word')
    set_key('g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], 'Goto next occurence of nearest word')
    set_key('g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], 'Goto previous occurence of nearest word')
    set_key('<Leader>h', '<Cmd>noh<CR>', 'Disable search highlights')
  end,
}
