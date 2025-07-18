-- Using a higher value for n_lines helps catch multi-line text objects easier
local n_lines = 500

return {
  {
    -- Better [a]round and [i]nside text objects
    -- Main textobject prefixes
    -- around = 'a',
    -- inside = 'i',
    --
    -- Next/last variants
    -- around_next = 'an',
    -- inside_next = 'in',
    -- around_last = 'al',
    -- inside_last = 'il',
    --
    -- Move cursor to corresponding edge of `a` textobject
    -- goto_left = 'g[',
    -- goto_right = 'g]',
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = {
      n_lines = n_lines,
    },
  },
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {
      modes = { insert = true, command = true, terminal = true },
      mappings = {
        ['<'] = { action = 'open', pair = '<>', neigh_pattern = '[^\\].' },
        ['>'] = { action = 'close', pair = '<>', neigh_pattern = '[^\\].' },
      },
    },
  },
  {
    -- Better [s]urround actions
    -- add = 'sa', -- Add surrounding in Normal and Visual modes
    -- delete = 'sd', -- Delete surrounding
    -- find = 'sf', -- Find surrounding (to the right)
    -- find_left = 'sF', -- Find surrounding (to the left)
    -- highlight = 'sh', -- Highlight surrounding
    -- replace = 'sr', -- Replace surrounding
    -- update_n_lines = 'sn', -- Update `n_lines`
    --
    -- suffix_last = 'l', -- Suffix to search with "prev" method
    -- suffix_next = 'n', -- Suffix to search with "next" method
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      n_lines = n_lines,
      respect_selection_type = true,
      search_method = 'cover_or_nearest',
    },
  },
  -- Highlights trailing whitespace.
  -- Some LSP's (like luals) handle this already.
  { 'echasnovski/mini.trailspace', opts = {} },
  {
    'echasnovski/mini.statusline',
    dependencies = { 'echasnovski/mini.icons', opts = {} },
    opts = function(_, opts)
      local my_opts = {
        use_icons = vim.g.have_nerd_font,
      }
      opts = vim.tbl_deep_extend('force', opts or {}, my_opts)

      -- short form line indicator
      ---@diagnostic disable-next-line: duplicate-set-field
      require('mini.statusline').section_location = function()
        return '%2l:%-2v'
      end

      return opts
    end,
  },
}
