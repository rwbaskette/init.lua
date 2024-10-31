require("rwb.opt")
require("rwb.remap")



vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.cmd("syntax off")

b16t = os.getenv("BASE16_THEME")
if b16t ~= nil and b16t ~= "" then
  vim.cmd("let base16colorspace=256")
  vim.cmd("colorscheme base16-" .. b16t)
else
  -- modern or classic
  vim.g.BorlandStyle = "classic"
  vim.g.BorlandParen = "1"
  vim.cmd("colorscheme borland")
end

