---@param lhs  string
---@param rhs  string | function
---@param desc string
---@param opts vim.keymap.set.Opts | { mode?: string|string[] }
function set_global_keymap(lhs, rhs, desc, opts)
  local opts = opts or {}
  local mode = table.removekey(opts, 'mode') or 'n'
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

set_global_keymap('<Esc>', ':nohlsearch<CR>', 'Clear search highlights')

-- Center screen when jumping
set_global_keymap('n', 'nzzzv', 'Next search result (centered)')
set_global_keymap('N', 'Nzzzv', 'Previous search result (centered)')
set_global_keymap('<C-d>', '<C-d>zz', 'Half page down (centered)')
set_global_keymap('<C-u>', '<C-u>zz', 'Half page up (centered)')

-- Paste without yanking in visual mode
set_global_keymap('p', 'P', 'Paste without yanking', { mode = 'x' })
set_global_keymap('y%', function()
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
set_global_keymap("<C-h>", "<C-w>h", "Move to left window")
set_global_keymap("<C-j>", "<C-w>j", "Move to bottom window")
set_global_keymap("<C-k>", "<C-w>k", "Move to top window")
set_global_keymap("<C-l>", "<C-w>l", "Move to right window")

-- NOTE: you can create splits with <C-W>s and <C-W>v
-- Resize splits
set_global_keymap("<C-Up>", ":resize +2<CR>", "Increase window height")
set_global_keymap("<C-Down>", ":resize -2<CR>", "Decrease window height")
set_global_keymap("<C-Left>", ":vertical resize -2<CR>", "Decrease window width")
set_global_keymap("<C-Right>", ":vertical resize +2<CR>", "Increase window width")

-- Move lines up/down
set_global_keymap("<A-j>", ":m .+1<CR>==", "Move line down")
set_global_keymap("<A-k>", ":m .-2<CR>==", "Move line up")
set_global_keymap("<A-j>", ":m '>+1<CR>gv=gv", "Move selection down", { mode = 'v' })
set_global_keymap("<A-k>", ":m '<-2<CR>gv=gv", "Move selection up", { mode = 'v' })

-- VSCode indenting in visual mode
set_global_keymap("<Tab>", ">gv", "Indent right and reselect", { mode = "v" })
set_global_keymap("<S-Tab>", "<gv", "Indent left and reselect", { mode = "v" })
