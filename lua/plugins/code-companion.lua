return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    {
      'ellisonleao/dotenv.nvim',
      -- this nesting is disgusting...
      dependencies = { 'folke/snacks.nvim' },
      lazy = false,
      opts = { enable_on_load = false },
      config = function(opts, _)
        opts = opts or {}
        require('dotenv').setup(opts)
        -- NOTE: ~/.config/nvim/.env
        local dotenv_path = vim.fs.joinpath(vim.fn.stdpath 'config', '.env')
        local success, result = pcall(vim.cmd, 'Dotenv ' .. dotenv_path)
        if not success then
          Snacks.notify.warn('Dotenv failed to load: ' .. dotenv_path, { title = 'Dotenv' })
          Snacks.notify.notify('Dotenv result: ' .. result, { title = 'Dotenv', level = 'debug' })
        end
      end,
    },
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    {
      '<leader>aa',
      '<cmd>CodeCompanionActions<cr>',
      desc = 'AI [A]ctions',
    },
    {
      '<leader>ac',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = 'Toggle AI [C]hat',
    },
  },
  opts = {
    adapters = {
      ollama = function()
        local base_url = os.getenv 'OLLAMA_BASE_URL' or 'http://localhost:11434'
        return require('codecompanion.adapters').extend('ollama', {
          env = {
            url = base_url,
          },
          headers = {
            ['Content-Type'] = 'application/json',
          },
          parameters = {
            sync = true,
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = 'ollama',
      },
      inline = {
        adapter = 'ollama',
      },
    },
  },
}
