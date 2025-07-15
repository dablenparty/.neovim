return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  event = {
    'BufReadPre */obsidian/*/*.md',
    'BufNewFile */obsidian/*/*.md',
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
    'saghen/blink.cmp',
    'folke/snacks.nvim',
    'nvim-treesitter/nvim-treesitter',
    'OXY2DEV/markview.nvim',
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/obsidian/vault/',
      },
    },

    notes_subdir = 'Notes',
    new_notes_location = 'notes_subdir',

    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 1,
    },

    templates = {
      folder = 'Templates',
    },

    wiki_link_func = 'prepend_note_path',

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
      name = 'snacks.pick',
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = '<C-x>',
        -- Insert a link to the selected note.
        insert_link = '<C-l>',
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = '<C-x>',
        -- Insert a tag at the current location.
        insert_tag = '<C-l>',
      },
    },

    attachments = {
      img_folder = 'attachments',
    },
  },
}
