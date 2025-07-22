return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', { 'echasnovski/mini.icons', version = false, opts = {} } },
    ft = { 'markdown', 'quarto', 'text', 'gitcommit' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { blink = { enabled = true } },
      heading = { border = true, border_virtual = true }
    },
  },
  {
    'bullets-vim/bullets.vim',
    ft = { 'gitcommit', 'markdown', 'text', 'scratch' },
    -- NOTE: opts won't work, bullets is VimScript
    config = function() end
  }
}
