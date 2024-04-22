--vim.opt.guicursor = ""

vim.opt.termguicolors = true

vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Allow hidden buffers (e.g. switch between unsaved buffers)
vim.opt.hidden = true

vim.opt.clipboard = "unnamed"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.opt.history = 1000
vim.opt.so = 5
vim.opt.ruler = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.backspace = "eol,start,indent"
vim.opt.startofline = false       		-- don't jump to first character when paging
vim.opt.whichwrap = "b,s,h,l,<,>,[,]"  		-- move freely between lines

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.lazyredraw = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.sm = true
vim.opt.foldlevel = 50
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldmethod = "indent"
vim.opt.ttyfast = true
vim.opt.title = true
vim.opt.modeline = true  	   		-- last lines in document sets vim mode
vim.opt.modelines = 12    			-- number lines checked for modelines
vim.opt.encoding = "utf-8"
vim.opt.termencoding = "utf-8"
--vim.opt.ffs = "unix,dos,mac"
--vim.opt.binary = true
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

