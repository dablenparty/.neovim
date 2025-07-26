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

---Add/remove a character at the end of a line
---@param eol_str string
M.toggle_str_at_eol = function(eol_str)
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
    local line = lines[(row - start_row) + 1]
    -- subtract 1 because start of range is inclusive
    local last_char = line:sub(#line - (#eol_str - 1), #line)
    if last_char == eol_str then
      -- remove char
      vim.api.nvim_buf_set_text(0, row, #line - #eol_str, row, #line, {})
    else
      -- add char
      vim.api.nvim_buf_set_text(0, row, #line, row, #line, { eol_str })
    end
  end
end

return M
