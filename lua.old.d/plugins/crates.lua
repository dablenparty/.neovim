return {
  'saecki/crates.nvim',
  -- uncomment if you're having issues
  -- tag = 'stable',
  event = { 'BufRead Cargo.toml' },
  cmd = { 'Crates' },
  opts = {
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  },
  config = function(_, opts)
    opts = opts or {}
    require('crates').setup(opts)

    local crates = require 'crates'

    -- NOTE: If keys are defined in the plugin spec, they'll act as lazy-loaders for the plugin.
    -- I don't want that, I only want the keymaps set if this plugin is already loaded.

    vim.keymap.set('n', '<leader>ct', crates.toggle, { silent = true, desc = 'Toggle Crates UI' })
    vim.keymap.set('n', '<leader>cr', crates.reload, { silent = true, desc = 'Reload Crate Data' })

    vim.keymap.set('n', '<leader>cv', crates.show_versions_popup, { silent = true, desc = 'Show Crate Versions' })
    vim.keymap.set('n', '<leader>cf', crates.show_features_popup, { silent = true, desc = 'Show Crate Features' })
    vim.keymap.set('n', '<leader>cd', crates.show_dependencies_popup, { silent = true, desc = 'Show Crate Dependencies' })

    vim.keymap.set('n', '<leader>cu', crates.update_crate, { silent = true, desc = 'Update Crate' })
    vim.keymap.set('v', '<leader>cu', crates.update_crates, { silent = true, desc = 'Update Selected Crates' })
    vim.keymap.set('n', '<leader>cU', crates.upgrade_crate, { silent = true, desc = 'Upgrade Crate' })
    vim.keymap.set('v', '<leader>cU', crates.upgrade_crates, { silent = true, desc = 'Upgrade Selected Crates' })
    vim.keymap.set('n', '<leader>cA', crates.upgrade_all_crates, { silent = true, desc = 'Upgrade All Crates' })

    vim.keymap.set('n', '<leader>cx', crates.expand_plain_crate_to_inline_table, { silent = true, desc = 'Expand Inline Crate Table' })
    vim.keymap.set('n', '<leader>cX', crates.extract_crate_into_table, { silent = true, desc = 'Extract Crate to Table' })

    vim.keymap.set('n', '<leader>cH', crates.open_homepage, { silent = true, desc = 'Open Crate Homepage' })
    vim.keymap.set('n', '<leader>cR', crates.open_repository, { silent = true, desc = 'Open Crate Repository' })
    vim.keymap.set('n', '<leader>cD', crates.open_documentation, { silent = true, desc = 'Open Crate Documentation' })
    vim.keymap.set('n', '<leader>cC', crates.open_crates_io, { silent = true, desc = 'Open crates.io' })
    vim.keymap.set('n', '<leader>cL', crates.open_lib_rs, { silent = true, desc = 'Open lib.rs' })
  end,
}
