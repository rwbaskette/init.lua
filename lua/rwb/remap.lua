vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", vim.cmd.write)
vim.keymap.set("n", "<C-S>", vim.cmd.write)

vim.keymap.set("n", "<leader><Tab>", ":b#\n")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("v", "<leader>y", "\"+y")

vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>p", "\"+P")
vim.keymap.set("v", "<leader>p", "\"+p")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fo', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


--- rwb copium
vim.keymap.set("n", "<C-p>", builtin.buffers )
vim.keymap.set("n", "<C-o>", builtin.find_files)

vim.keymap.set("v", "<F5>", ":'<,'>w !q<CR>")
