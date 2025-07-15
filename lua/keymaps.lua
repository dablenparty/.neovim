vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

function set_global_keymap(lhs, rhs, desc, opts)
  local opts = opts or {}
  opts.desc = desc
  local mode = opts.mode and vim.fn.remove(opts, 'mode') or 'n'
  vim.keymap.set(mode, lhs, rhs, opts)
end

set_global_keymap('<Esc>', ':nohlsearch<CR>', 'Clear search highlights')

