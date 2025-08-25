return {
  'saghen/blink.cmp',
  -- provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  version = '1.*',
  -- Build from source with Rust nightly
  build = 'rustup run nightly cargo build --release',

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

    completion = {
      menu = {
        border = 'none',
        draw = {
          -- treesitter highlighting for LSP sources
          treesitter = { 'lsp' },
          -- Components to render, grouped by column
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
          components = {
            source_name = {
              text = function(ctx)
                if ctx.source_id == 'cmdline' then
                  return 'cmdline'
                end
                return ctx.source_name:sub(1, 4)
              end,
            },
          },
        },
        scrolloff = 1,
      },
      documentation = { auto_show = false },
    },

    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      sorts = {
        'exact',
        'score',
        'sort_text',
      },
    },

    sources = {
      per_filetype = {
        codecompanion = { 'codecompanion' },
        lua = { inherit_defaults = true, 'lazydev' },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      default = { 'lsp', 'buffer', 'path', 'snippets' },

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
  },
  opts_extend = { 'sources.default' },
}
