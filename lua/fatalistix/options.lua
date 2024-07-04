vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes:1'
vim.opt.isfname:append('@-@') -- appends '@' character

vim.opt.updatetime = 1000
vim.opt.colorcolumn = '120'

vim.opt.clipboard:append('unnamedplus')

-- allows using <Leader>
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- show some invisible characters (tabs...)
vim.opt.list = true

-- enable mouse
vim.opt.mouse = 'a'

-- enables pseudotransparency for popup-menu values from 0 to 100
vim.opt.pumblend = 10
vim.opt.pumheight = 15

-- Round indent to multiple of 'shiftwidth'.  Applies to > and < commands.
vim.opt.shiftround = true

-- every wrapped line will continue visually indented
-- wrap indent to match line start
vim.opt.breakindent = true

-- file content encoding for the buffer
vim.opt.fileencoding = "utf-8"

-- fold options (arrows in the left)
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.foldcolumn = '1'
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

