return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@module "flash"
  ---@type Flash.Config
  opts = {
    search = {
      incremental = true,
    },
    label = {
      -- only seems to affect f,F,t,T motions, but I'll keep it here just in case
      style = 'inline',
      rainbow = { enabled = true },
    },
    modes = {
      -- I want to use this, but it breaks some actions (mainly deleting) that I use a lot
      char = { enabled = false },
    },
  },
  keys = {
    {
      '<leader>jf',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = '[F]lash',
    },
    {
      '<leader>jt',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash [T]reesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = '[R]emote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Flash Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}
