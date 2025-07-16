-- NOTE: import all utils before doing anything else
require 'utils'

-- SECTION: Visuals
-- NOTE: colorscheme must come before highlights
vim.cmd.colorscheme('unokai')
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
vim.api.nvim_set_hl(0, 'EndOfBuffer', { bg = 'none' })
vim.g.have_nerd_font = true
-- TODO: auto cmdheight
vim.opt.cmdheight = 1
-- highlight column 90
vim.opt.colorcolumn = '90'
-- don't hide markup text
vim.opt.concealcursor = ''
vim.opt.conceallevel = 1
vim.opt.cursorline = true
vim.opt.number = true
-- popup menu transparency
vim.opt.pumblend = 8
vim.opt.pumheight = 8
-- TODO: auto-relative numbers
vim.opt.relativenumber = true
-- highlight matching bracket(s)
vim.opt.showmatch = true
vim.opt.signcolumn = 'yes'
-- enable 24-bit color
vim.opt.termguicolors = true
-- floating window transparency
vim.opt.winblend = 0

-- SECTION: Basic Text Processing
vim.opt.autoindent = true
-- maintain indentation for wrapped text
vim.opt.breakindent = true
-- use spaces instead of tabs
vim.opt.expandtab = true
-- controls how whitespace is displayed
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.sidescrolloff = 8
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.wrap = true

-- SECTION: Searching
vim.opt.hlsearch = true
vim.opt.ignorecase = true
-- show live substitutions in the preview window
vim.opt.inccommand = 'split'
-- show matches while typing
vim.opt.incsearch = true
vim.opt.smartcase = true

-- SECTION: Autocompletion
vim.opt.completeopt = 'fuzzy,menuone,noinsert,noselect,popup'

-- SECTION: File Handling
vim.opt.autoread = true
vim.opt.autowrite = false
-- disable "backup" files
vim.opt.backup = false
vim.opt.swapfile = false
-- mapped sequence timeout
vim.opt.timeoutlen = 450
-- key code sequence timeout
vim.opt.ttimeoutlen = 0
-- persist undo history to a state file
vim.opt.undofile = true
-- update faster for faster autocomplete
vim.opt.updatetime = 250
-- don't write "backup" files
vim.opt.writebackup = false

-- SECTION: General Behavior
vim.opt.backspace = 'indent,eol,start'
-- yank text to registers "+" and "*", and to system clipboard
vim.opt.clipboard:append('unnamedplus')
vim.opt.errorbells = false
vim.opt.hidden = true
-- treat "-" as part of a keyword (e.g. kebab-case becomes one keyword)
vim.opt.iskeyword:append('-')
-- allow buffers to be modified
vim.opt.modifiable = true
vim.opt.mouse = 'a'
-- include subdirs in path search
vim.opt.path:append('**')
vim.opt.selection = 'exclusive'
vim.opt.splitbelow = true
vim.opt.splitright = true

-- SECTION: Folding
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- start with all folds open
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'

-- SECTION: Imports
require 'autocmds'
require 'keymaps'
