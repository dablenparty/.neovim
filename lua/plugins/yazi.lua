return {
  {
    'mikavilpas/yazi.nvim',
    cmd = 'Yazi',
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>y',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Open [Y]azi at current file',
      },
      {
        -- Open in the current working directory
        '-',
        '<cmd>Yazi cwd<cr>',
        desc = 'Open yazi in CWD',
      },
    },
    init = function()
      -- disable netrw
      -- vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    ---@module 'yazi'
    ---@type YaziConfig | {}
    opts = {
      -- don't open by default, sometimes I want to use a picker
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
  {
    'nvim-lua/plenary.nvim', lazy = true
  }
}
