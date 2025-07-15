return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  dependencies = { 'folke/snacks.nvim', lazy = true },
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
  ---@type YaziConfig | {}
  opts = {
    -- use yazi as default file explorer instead of netrw
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
  },
}
