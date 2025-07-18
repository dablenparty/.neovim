return {
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        '<leader>y',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = '[Y]azi',
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
    ---@type YaziConfig | {}
    opts = {
      -- use yazi as default file explorer instead of netrw
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
