---Remove `key` from the given table `tbl`. If `key` is not in `tbl`, this is a no-op.
---@param tbl table
---@param key string
---@return any `tbl[key]` or `nil`
function table.removekey(tbl, key)
  local value = tbl[key]
  tbl[key] = nil
  return value
end
