require("telescope").setup{
	pickers = {
		buffers = {
		    sort_lastused=1,
		    ignore_current_buffer=1
		}
	}
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fo', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


--- rwb copium
vim.keymap.set("n", "<C-p>", builtin.buffers )
vim.keymap.set("n", "<C-o>", builtin.find_files)


--[[ Go-specific Telescope pickers ]] --
vim.keymap.set('n', '<leader>gf', function()
  require('telescope.builtin').find_files({
    prompt_title = "Go Files",
    find_command = { "find", "-type", "f", "-name", "*.go" }
  })
end, {})

vim.keymap.set('n', '<leader>gt', function()
  require('telescope.builtin').find_files({
    prompt_title = "Go Test Files",
    find_command = { "find", "-type", "f", "-name", "*_test.go" }
  })
end, {})

vim.keymap.set('n', '<leader>gm', function()
  require('telescope.builtin').find_files({
    prompt_title = "Go Modules",
    find_command = { "find", "-type", "f", "-name", "go.mod" }
  })
end, {})

vim.keymap.set('n', '<leader>gw', function()
  require('telescope.builtin').grep_string({
    prompt_title = "Go Methods/Functions",
    search = "^func"
  })
end, {})

vim.keymap.set('n', '<leader>ge', function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols({
    prompt_title = "Go Symbols",
    symbols = { "function", "method", "struct", "interface", "type" }
  })
end, {})
