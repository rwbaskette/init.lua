require("rwb.telescope")
require("rwb.packer")
require("rwb.lualine")
require("rwb.opt")
require("rwb.remap")
require("rwb.lsp")

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.cmd("syntax off")

-- modern or classic
vim.g.BorlandStyle = "classic"
vim.g.BorlandParen = "1"
vim.cmd("colorscheme borland")
--vim.cmd("colorscheme zellner")
