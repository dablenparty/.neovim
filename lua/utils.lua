---@param tbl table
---@param key string
function table.removekey(tbl, key)
  local value = tbl[key]
  tbl[key] = nil
  return value
end
