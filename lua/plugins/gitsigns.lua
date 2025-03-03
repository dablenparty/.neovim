return {
  'lewis6991/gitsigns.nvim',
  dependencies = { 'folke/snacks.nvim' },
  opts = {
    attach_to_untracked = true,
    current_line_blame = true,
    on_attach = function(bufnr)
      local gitsigns = require 'gitsigns'

      ---@param mode string|string[]
      ---@param l string
      ---@param r function|string
      ---@param opts? vim.keymap.set.Opts
      local function set_key(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      set_key('n', '<leader>ghp', gitsigns.preview_hunk, { desc = '[g]it [H]unk [P]review' })
      set_key('n', '<leader>ghi', gitsigns.preview_hunk_inline, { desc = '[g]it [H]unk H[i]ghlight' })

      set_key('n', '<leader>gb', function()
        gitsigns.blame_line { full = true }
      end, { desc = '[g]it line [b]lame' })

      set_key('n', '<leader>gd', gitsigns.diffthis, { desc = '[g]it [d]iff against index' })

      set_key('n', '<leader>gD', function()
        gitsigns.diffthis '~'
      end, { desc = '[g]it [d]iff against last commit' })

      set_key('n', '<leader>ghq', gitsigns.setqflist, { desc = 'Send buffer [g]it [h]unks to [q]uickfix' })
      set_key('n', '<leader>ghQ', function()
        gitsigns.setqflist 'all'
      end, { desc = 'Send all [g]it [h]unks to [q]uickfix' })

      -- Toggles
      Snacks.toggle
        .new({
          name = 'Current Line Blame',
          get = function()
            return require('gitsigns.config').config.current_line_blame
          end,
          set = function(state)
            -- do not invert state; gitsigns does that itself internally
            gitsigns.toggle_current_line_blame(state)
          end,
        })
        :map '<leader>gub'
      Snacks.toggle
        .new({
          name = 'Inline Word Diff',
          get = function()
            return require('gitsigns.config').config.word_diff
          end,
          set = function(state)
            -- do not invert state; gitsigns does that itself internally
            gitsigns.toggle_word_diff(state)
          end,
        })
        :map '<leader>guw'

      -- Text object
      set_key({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
    end,
  },
}
