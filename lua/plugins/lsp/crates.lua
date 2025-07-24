return {
  'saecki/crates.nvim',
  -- uncomment if you're having issues
  -- tag = 'stable',
  event = { 'BufRead Cargo.toml' },
  cmd = { 'Crates' },
  opts = function(_, opts)
    opts = opts or {}
    local set_global_keymap = require('utils').set_global_keymap

    -- NOTE: If keys are defined in the plugin spec, they'll act as lazy-loaders for the plugin.
    -- I don't want that, I only want the keymaps set if this plugin is already loaded.

    set_global_keymap('<leader>ct', function()
      require('crates').toggle()
    end, 'Toggle Crates UI', { silent = true, mode = 'n' })
    set_global_keymap('<leader>cr', function()
      require('crates').reload()
    end, 'Reload Crate Data', { silent = true })

    set_global_keymap('<leader>cv', function()
      require('crates').show_versions_popup()
    end, 'Show Crate Versions', { silent = true })
    set_global_keymap('<leader>cf', function()
      require('crates').show_features_popup()
    end, 'Show Crate Features', { silent = true })
    set_global_keymap('<leader>cd', function()
      require('crates').show_dependencies_popup()
    end, 'Show Crate Dependencies', { silent = true })

    set_global_keymap('<leader>cu', function()
      require('crates').update_crate()
    end, 'Update Crate', { silent = true })
    set_global_keymap('<leader>cu', function()
      require('crates').update_crates()
    end, 'Update Selected Crates', { silent = true, mode = 'v' })
    set_global_keymap('<leader>cU', function()
      require('crates').upgrade_crate()
    end, 'Upgrade Crate', { silent = true })
    set_global_keymap('<leader>cU', function()
      require('crates').upgrade_crates()
    end, 'Upgrade Selected Crates', { silent = true, mode = 'v' })
    set_global_keymap('<leader>cA', function()
      require('crates').upgrade_all_crates()
    end, 'Upgrade All Crates', { silent = true })

    set_global_keymap('<leader>cx', function()
      require('crates').expand_plain_crate_to_inline_table()
    end, 'Expand Inline Crate Table', { silent = true })
    set_global_keymap('<leader>cX', function()
      require('crates').extract_crate_into_table()
    end, 'Extract Crate to Table', { silent = true })

    set_global_keymap('<leader>cH', function()
      require('crates').open_homepage()
    end, 'Open Crate Homepage', { silent = true })
    set_global_keymap('<leader>cR', function()
      require('crates').open_repository()
    end, 'Open Crate Repository', { silent = true })
    set_global_keymap('<leader>cD', function()
      require('crates').open_documentation()
    end, 'Open Crate Documentation', { silent = true })
    set_global_keymap('<leader>cC', function()
      require('crates').open_crates_io()
    end, 'Open crates.io', { silent = true })
    set_global_keymap('<leader>cL', function()
      require('crates').open_lib_rs()
    end, 'Open lib.rs', { silent = true })

    local my_opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    }
    opts = vim.tbl_deep_extend('force', opts, my_opts)

    return opts
  end,
}
