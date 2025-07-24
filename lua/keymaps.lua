vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local set_global_keymap = require('utils').set_global_keymap

set_global_keymap('<Esc>', ':nohlsearch<CR>', 'Clear search highlights', { silent = true })

-- Center screen when jumping
set_global_keymap('n', 'nzzzv', 'Next search result (centered)')
set_global_keymap('N', 'Nzzzv', 'Previous search result (centered)')
set_global_keymap('<C-d>', '<C-d>zz', 'Half page down (centered)')
set_global_keymap('<C-u>', '<C-u>zz', 'Half page up (centered)')

-- Paste without yanking in visual mode
set_global_keymap('p', 'P', 'Paste without yanking', { mode = 'x' })
set_global_keymap('y!', function()
  local clipboard = vim.opt.clipboard:get()
  local register = ''
  if vim.tbl_contains(clipboard, 'unnamedplus') then
    register = '+'
  elseif vim.tbl_contains(clipboard, 'unnamed') then
    register = '*'
  end
  return string.format(':%%y%s<CR>', register)
end, 'Yank buffer', { expr = true })

-- navigate windows easier
set_global_keymap('<C-h>', '<C-w>h', 'Move to left window')
set_global_keymap('<C-j>', '<C-w>j', 'Move to bottom window')
set_global_keymap('<C-k>', '<C-w>k', 'Move to top window')
set_global_keymap('<C-l>', '<C-w>l', 'Move to right window')

-- NOTE: you can create splits with <C-W>s and <C-W>v
-- Resize splits
set_global_keymap('<C-Up>', ':resize +2<CR>', 'Increase window height')
set_global_keymap('<C-Down>', ':resize -2<CR>', 'Decrease window height')
set_global_keymap('<C-Left>', ':vertical resize -2<CR>', 'Decrease window width')
set_global_keymap('<C-Right>', ':vertical resize +2<CR>', 'Increase window width')

-- Move lines up/down
set_global_keymap('<A-j>', ':m .+1<CR>==', 'Move line down')
set_global_keymap('<A-k>', ':m .-2<CR>==', 'Move line up')
set_global_keymap('<A-j>', ":m '>+1<CR>gv=gv", 'Move selection down', { mode = 'v' })
set_global_keymap('<A-k>', ":m '<-2<CR>gv=gv", 'Move selection up', { mode = 'v' })

-- VSCode-style indenting in visual mode
set_global_keymap('<Tab>', '>gv', 'Indent right and reselect', { mode = 'v' })
set_global_keymap('<S-Tab>', '<gv', 'Indent left and reselect', { mode = 'v' })

---Add/remove a character at the end of a line
---@param char string
local function toggle_char_at_eol(char)
  local visual_modes = { ['v'] = true, ['V'] = true, ['\22'] = true }
  -- subtract 1 because line indices are 1-based
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1
  local mode = vim.api.nvim_get_mode().mode
  local start_row, end_row

  if visual_modes[mode] then
    -- Using marks '< and '> is a little hacky because those marks are only set when
    -- EXITING visual mode. So, to prevent changing modes, we instead explicitly fetch
    -- the line numbers of both ends of the Visual area, one of which is conveniently the
    -- cursor. See `:h getpos()` for more info.
    local visual_end_line = vim.fn.line 'v' - 1
    -- WARN: Because the cursor could be at the top OR bottom of the region, the
    -- start/end rows must be checked before being assigned.
    if cursor_line < visual_end_line then
      start_row = cursor_line
      end_row = visual_end_line
    else
      start_row = visual_end_line
      end_row = cursor_line
    end
  else
    start_row = cursor_line
    end_row = start_row
  end

  local strict_indexing = true
  local lines = vim.api.nvim_buf_get_lines(0, start_row, end_row + 1, strict_indexing)

  for row = start_row, end_row do
    -- local row = cursor_pos[1] - 1
    local line = lines[(row - start_row) + 1]
    local last_char = line:sub(#line, #line)
    if last_char == char then
      -- remove char
      vim.api.nvim_buf_set_text(0, row, #line - 1, row, #line, {})
    else
      -- add char
      vim.api.nvim_buf_set_text(0, row, #line, row, #line, { char })
    end
  end
end

set_global_keymap(';', function()
  toggle_char_at_eol ';'
end, 'Toggle semi-colon at EOL', { mode = { 'n', 'x' } })
set_global_keymap(',', function()
  toggle_char_at_eol ','
end, 'Toggle comma at EOL', { mode = { 'n', 'x' } })
