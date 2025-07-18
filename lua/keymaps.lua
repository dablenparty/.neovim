vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

M = {}

---Set a global keymap. All args are passed directly to `vim.keymap.set()` except `opts`.
---If `opts.desc` is defined, it is ovewritten by the positional `desc`. If `opts.mode`
---is defined, it is removed from `opts` and used as the keymap mode.
---@param lhs  string
---@param rhs  string | function
---@param desc string
---@param opts vim.keymap.set.Opts | { mode?: string|string[] }?
M.set_global_keymap = function(lhs, rhs, desc, opts)
  opts = opts or {}
  local mode = table.removekey(opts, 'mode') or 'n'
  opts.desc = desc
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.set_global_keymap('<Esc>', ':nohlsearch<CR>', 'Clear search highlights', { silent = true })

-- Center screen when jumping
M.set_global_keymap('n', 'nzzzv', 'Next search result (centered)')
M.set_global_keymap('N', 'Nzzzv', 'Previous search result (centered)')
M.set_global_keymap('<C-d>', '<C-d>zz', 'Half page down (centered)')
M.set_global_keymap('<C-u>', '<C-u>zz', 'Half page up (centered)')

-- Paste without yanking in visual mode
M.set_global_keymap('p', 'P', 'Paste without yanking', { mode = 'x' })
M.set_global_keymap('y%', function()
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
M.set_global_keymap("<C-h>", "<C-w>h", "Move to left window")
M.set_global_keymap("<C-j>", "<C-w>j", "Move to bottom window")
M.set_global_keymap("<C-k>", "<C-w>k", "Move to top window")
M.set_global_keymap("<C-l>", "<C-w>l", "Move to right window")

-- NOTE: you can create splits with <C-W>s and <C-W>v
-- Resize splits
M.set_global_keymap("<C-Up>", ":resize +2<CR>", "Increase window height")
M.set_global_keymap("<C-Down>", ":resize -2<CR>", "Decrease window height")
M.set_global_keymap("<C-Left>", ":vertical resize -2<CR>", "Decrease window width")
M.set_global_keymap("<C-Right>", ":vertical resize +2<CR>", "Increase window width")

-- Move lines up/down
M.set_global_keymap("<A-j>", ":m .+1<CR>==", "Move line down")
M.set_global_keymap("<A-k>", ":m .-2<CR>==", "Move line up")
M.set_global_keymap("<A-j>", ":m '>+1<CR>gv=gv", "Move selection down", { mode = 'v' })
M.set_global_keymap("<A-k>", ":m '<-2<CR>gv=gv", "Move selection up", { mode = 'v' })

-- VSCode-style indenting in visual mode
M.set_global_keymap("<Tab>", ">gv", "Indent right and reselect", { mode = "v" })
M.set_global_keymap("<S-Tab>", "<gv", "Indent left and reselect", { mode = "v" })

return M
