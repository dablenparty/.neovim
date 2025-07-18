return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      -- indent guides
      indent = { enabled = true },
      -- better vim.ui.input
      input = { enabled = true },
      lazygit = { enabled = true },
      -- better vim.notify
      notifier = { enabled = true },
      picker = { enabled = true },
      -- render file asap before plugins
      quickfile = { enabled = true },
      -- LSP-integrated renaming
      rename = { enabled = true },
      statuscolumn = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
    },
    keys = {
      {
        '<leader>.',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<leader>S',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Buffer',
      },
      {
        '<leader>n',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
      {
        '<leader>un',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Dismiss All Notifications',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },

      --! Picker Binds
      -- Top Pickers & Explorer
      {
        '<leader>:',
        function()
          Snacks.picker.command_history()
        end,
        desc = 'Command History',
      },
      -- find
      {
        '<leader>fs',
        function()
          Snacks.picker.smart()
        end,
        desc = 'Smart Find Files',
      },
      {
        '<leader>fb',
        function()
          Snacks.picker.buffers()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>fn',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = 'Find Config File',
      },
      {
        '<leader>fg',
        function()
          Snacks.picker.git_files()
        end,
        desc = 'Find Git Files',
      },
      -- git
      {
        '<leader>lf',
        function()
          Snacks.lazygit.log_file()
        end,
        desc = '[L]azygit Current [F]ile History',
      },
      {
        '<leader>lg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>ll',
        function()
          Snacks.lazygit.log()
        end,
        desc = '[L]azygit [L]og (cwd)',
      },
      -- Grep
      {
        '<leader>/',
        function()
          Snacks.picker.lines()
        end,
        desc = 'Buffer Lines',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = 'Visual selection or word',
        mode = { 'n', 'x' },
      },
      -- search
      {
        '<leader>sc',
        function()
          Snacks.picker.commands()
        end,
        desc = 'Commands',
      },
      {
        '<leader>sD',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = 'Buffer Diagnostics',
      },
      {
        '<leader>sf',
        function()
          Snacks.picker.files { hidden = true, follow = true }
        end,
        desc = 'Search Files',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = 'Help Pages',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = 'Keymaps',
      },
      {
        '<leader>sl',
        function()
          Snacks.picker.loclist()
        end,
        desc = 'Location List',
      },
      {
        '<leader>sm',
        function()
          Snacks.picker.marks()
        end,
        desc = 'Marks',
      },
      {
        '<leader>sM',
        function()
          Snacks.picker.man()
        end,
        desc = 'Man Pages',
      },
      {
        '<leader>sp',
        function()
          Snacks.picker.lazy()
        end,
        desc = 'Search for Lazy Plugin Spec',
      },
      {
        '<leader>sq',
        function()
          Snacks.picker.qflist()
        end,
        desc = 'Quickfix List',
      },
      {
        '<leader>sR',
        function()
          Snacks.picker.resume()
        end,
        desc = 'Resume',
      },
      {
        '<leader>st',
        function()
          Snacks.picker.treesitter()
        end,
        desc = '[S]earch [T]reesitter Symbols',
      },
      {
        '<leader>su',
        function()
          Snacks.picker.undo()
        end,
        desc = 'Undo History',
      },
      {
        '<leader>sC',
        function()
          Snacks.picker.colorschemes()
        end,
        desc = 'Colorschemes',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
        end,
      })

      -- Enable LSP-related keybinds and autocommands
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('snacks-lsp-attach', { clear = true }),
        callback = function(event)
          ---@param keys string
          ---@param func function
          ---@param opts vim.keymap.set.Opts | { mode?: string|string[] }
          local function set_key(keys, func, opts)
            opts = opts or {}
            opts.desc = 'LSP: ' .. opts.desc
            vim.tbl_extend('keep', opts, { buffer = event.buf })

            -- `mode` is not a valid keymap opt, remove it
            local mode = table.removekey(opts, 'mode') or 'n'

            vim.keymap.set(mode, keys, func, opts)
          end

          set_key('gd', Snacks.picker.lsp_definitions, { desc = '[G]oto [D]efinition' })
          -- WARN: This is DECLARATION, not DEFINITION
          --  For example, in C this would take you to the header.
          set_key('gD', Snacks.picker.lsp_declarations, { desc = '[G]oto [D]eclaration' })
          set_key('gr', Snacks.picker.lsp_references, { nowait = true, desc = '[G]oto [R]eferences' })
          set_key('gI', Snacks.picker.lsp_implementations, { desc = '[G]oto [I]mplementation' })
          set_key('gy', Snacks.picker.lsp_type_definitions, { desc = '[G]oto T[y]pe Definition' })
          set_key('<leader>ss', Snacks.picker.lsp_symbols, { desc = 'LSP [S]ymbols' })
          set_key('<leader>sS', Snacks.picker.lsp_workspace_symbols, { desc = 'LSP Workspace [S]ymbols' })
          set_key('<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame Symbol' })
          set_key('<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction', mode = { 'n', 'x' } })

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            Snacks.toggle.inlay_hints():map '<leader>uh'
          end
        end,
      })
    end,
  },
  {
    'folke/todo-comments.nvim',
    optional = true,
    keys = {
      {
        '<leader>sT',
        function()
          Snacks.picker.todo_comments()
        end,
        desc = 'Todo',
      },
    },
  },
}
