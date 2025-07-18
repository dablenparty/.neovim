-- GROUP: Default
-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- GROUP: Filetype Fixes
local file_fixes_augroup = vim.api.nvim_create_augroup('filetype-fixes', { clear = true })

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = file_fixes_augroup,
  callback = function()
    -- expand the autocommand file path and take the head (dirname)
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Fix docker compose files being read as regular yaml
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  -- equivalent regex:
  -- (docker-)?compose.ya?ml
  -- see `:help pattern`
  pattern = { '{docker-}\\=compose.ya\\=ml' },
  group = file_fixes_augroup,
  command = 'set filetype=yaml.docker-compose',
})

-- Disable status column in manpages because it causes hard wrapping and setting
-- $MANWIDTH does not work
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'man' },
  group = file_fixes_augroup,
  command = 'set statuscolumn=',
})

-- GROUP: Terminal Enhancements
local term_augroup = vim.api.nvim_create_augroup('term-changes', { clear = true })

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = term_augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    vim.opt_local.statuscolumn = ''
  end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
  group = term_augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- GROUP: Language Server Protocol (LSP)
-- The following two autocommands are used to highlight references of the word under your
-- cursor when your cursor rests there for a little while. See `:help CursorHold` for
-- information about when this is executed When you move your cursor, the highlights will
-- be cleared (the second autocommand). This only enables when LSP is supported.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
  end,
})

-- GROUP: Status, Sign, and Line Number Columns
-- Modified from: https://github.com/sitiom/nvim-numbertoggle/blob/main/plugin/numbertoggle.lua
-- Show absolute line numbers in Insert mode and when the window loses focus
local relative_line_nums_augroup = vim.api.nvim_create_augroup('relative-line-numbers', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
  pattern = '*',
  group = relative_line_nums_augroup,
  callback = function()
    -- if line numbers are enabled
    if vim.o.nu then
      vim.opt.relativenumber = true
    end
  end,
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
  pattern = '*',
  group = relative_line_nums_augroup,
  callback = function()
    if vim.o.nu then
      vim.opt.relativenumber = false
      -- Conditional taken from https://github.com/rockyzhang24/dotfiles/commit/03dd14b5d43f812661b88c4660c03d714132abcf
      -- Workaround for https://github.com/neovim/neovim/issues/32068
      if not vim.tbl_contains({ '@', '-' }, vim.v.event.cmdtype) then
        vim.cmd 'redraw'
      end
    end
  end,
})

-- GROUP: Window Functions
local window_augroup = vim.api.nvim_create_augroup('window-funcs', { clear = true })

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = window_augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
