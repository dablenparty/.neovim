return {
  {
    'OXY2DEV/markview.nvim',
    dependencies = {
      'saghen/blink.cmp',
    },
    lazy = false,
    opts = function(_, opts)
      opts = opts or {}
      local presets = require 'markview.presets'

      return {
        experimental = {
          check_rtp = false,
        },
        markdown = {
          headings = presets.headings.glow,
          horizontal_rules = presets.horizontal_rules.thick,
          tables = presets.tables.rounded,
        },
      }
    end,
  },
  {
    'bullets-vim/bullets.vim',
    ft = { 'gitcommit', 'markdown', 'text', 'scratch' },
    config = function() end,
  },
}
