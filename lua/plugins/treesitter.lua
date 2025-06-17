return {
  {
    -- TODO: switch to main branch rewrite
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    keys = {
      { '<c-space>', desc = 'Increment Selection' },
      { '<bs>', desc = 'Decrement Selection', mode = 'x' },
    },
    config = function()
      local ensure_installed = {
        'bash',
        'c',
        'css',
        'diff',
        'dockerfile',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'latex',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'norg',
        'printf',
        'python',
        'query',
        'regex',
        'rust',
        'scss',
        'svelte',
        'toml',
        'tsx',
        'typescript',
        'typst',
        'vim',
        'vimdoc',
        'vue',
        'xml',
        'yaml',
      }

      -- mimics old behavior
      require('nvim-treesitter').install(ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = ensure_installed,
        callback = function(_)
          vim.treesitter.start()
          -- folds, provided by Neovim
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          -- NOTE: currently experimental and handled by `lua/plugins/snacks.lua`
          -- indentation, provided by nvim-treesitter
          -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      -- Autoinstall languages that are not installed
      auto_install = true,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    lazy = false,
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      {
        'ac',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
        end,
        desc = 'Select around class/struct',
      },
      {
        'ic',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
        end,
        desc = 'Select inside class/struct',
        mode = { 'x', 'o' },
      },
      {
        'af',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
        end,
        desc = 'Select around function',
        mode = { 'x', 'o' },
      },
      {
        'if',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
        end,
        desc = 'Select inside function',
        mode = { 'x', 'o' },
      },
      {
        'al',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@conditional.outer', 'textobjects')
        end,
        desc = 'Select around conditional',
        mode = { 'x', 'o' },
      },
      {
        'il',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@conditional.inner', 'textobjects')
        end,
        desc = 'Select inside conditional',
        mode = { 'x', 'o' },
      },
      {
        'ao',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@comment.outer', 'textobjects')
        end,
        desc = 'Select around comment',
        mode = { 'x', 'o' },
      },
      {
        'io',
        function()
          require('nvim-treesitter-textobjects.select').select_textobject('@comment.inner', 'textobjects')
        end,
        desc = 'Select inside comment',
        mode = { 'x', 'o' },
      },
    },
    opts = {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@function.outer'] = 'V', -- linewise
          ['@conditional.outer'] = 'V', -- linewise
          ['@parameter.outer'] = 'v', -- charwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include preceding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true or false
        include_surrounding_whitespace = false,
      },
      -- move = {
      --   goto_next_start = { [']f'] = '@function.outer', [']a'] = '@parameter.inner' },
      --   goto_next_end = { [']F'] = '@function.outer', [']A'] = '@parameter.inner' },
      --   goto_previous_start = { ['[f'] = '@function.outer', ['[a'] = '@parameter.inner' },
      --   goto_previous_end = { ['[F'] = '@function.outer', ['[A'] = '@parameter.inner' },
      -- },
      -- lsp_interop = {
      --   border = 'none',
      --   floating_preview_opts = { border = 'rounded' },
      -- },
    },
  },
}
