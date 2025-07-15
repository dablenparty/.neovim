return {
  'atiladefreitas/dooing',
  cmd = 'Dooing',
  keys = {
    {
      '<leader>td',
      '<cmd>Dooing<CR>',
      desc = '[T]oggle [D]ooing Window',
    },
  },
  opts = {
    -- store in config folder instead of data folder to keep in git
    save_path = vim.fn.stdpath 'config' .. '/dooing_todos.json',
    calendar = {
      keymaps = {
        -- more ergonomic for me
        select_day = '<space>',
      },
    },
  },
}
