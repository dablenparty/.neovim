-- SECTION: Table extensions

---Remove `key` from the given table `tbl`. If `key` is not in `tbl`, this is a no-op.
---@param tbl table
---@param key string
---@return any `tbl[key]` or `nil`
function table.removekey(tbl, key)
  local value = tbl[key]
  tbl[key] = nil
  return value
end

-- SECTION: Standalone Functions
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

return M
