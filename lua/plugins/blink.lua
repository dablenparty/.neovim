return {
  {
    'saghen/blink.nvim',
    keys = {
      -- chartoggle
      {
        ';',
        function()
          require('blink.chartoggle').toggle_char_eol ';'
        end,
        mode = { 'n', 'v' },
        desc = 'Toggle ; at EOL',
      },
      {
        ',',
        function()
          require('blink.chartoggle').toggle_char_eol ','
        end,
        mode = { 'n', 'v' },
        desc = 'Toggle , at EOL',
      },
    },
    -- all modules handle lazy loading internally
    lazy = false,
    opts = {
      chartoggle = { enabled = true },
    },
  },
  {
    'saghen/blink.cmp',
    -- provides snippets for the snippet source
    dependencies = 'rafamadriz/friendly-snippets',

    -- Build from source with Rust nightly
    build = 'rustup run nightly cargo build',

    event = { 'InsertEnter', 'LspAttach' },
    lazy = true,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-e: Hide menu
      -- C-k: Toggle signature help
      --
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = { preset = 'default' },

      appearance = {
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        per_filetype = {
          codecompanion = { 'codecompanion' },
        },

        default = function()
          -- Default list of enabled providers defined so that you can extend it
          -- elsewhere in your config, without redefining it, due to `opts_extend`
          local default_sources = { 'lsp', 'path', 'snippets', 'buffer' }

          -- Remove LSP sources when editing comments.
          -- Since some langauges have multiple comment types (and "comment_content" is its own node),
          -- simply checking if the node type has the word "comment" works better for me.
          local success, node = pcall(vim.treesitter.get_node)
          if success and node and node:type():find 'comment' then
            default_sources = { 'path', 'snippets', 'buffer' }
          end

          -- effectively a set, see: https://www.lua.org/pil/11.5.html
          local source_to_ft = {
            -- TODO: dadbod for SQL
            -- dadbod = { sql = true, mysql = true, plsql = true },
            lazydev = { lua = true },
          }

          local sources = default_sources
          for src, fts in pairs(source_to_ft) do
            if fts[vim.bo.filetype] then
              vim.list_extend(sources, { src })
            end
          end

          return sources
        end,

        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          path = {
            opts = {
              show_hidden_files_by_default = true,
            },
          },
        },
      },
      -- Blink.cmp uses a Rust fuzzy matcher by default for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
  },
}
