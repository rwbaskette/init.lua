-- Go-specific utilities and enhancements
local M = {}

function M.setup()
  -- Copy filepath:line:col to clipboard
  vim.keymap.set('n', '<leader>yP', function()
    local filepath = vim.fn.expand("%:p")
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local col = vim.api.nvim_win_get_cursor(0)[2] + 1
    local location = filepath .. ":" .. line .. ":" .. col
    vim.fn.setreg("+", location)
    vim.notify("Copied: " .. location, vim.log.levels.INFO)
  end, { desc = "Copy filepath:line:col to clipboard" })

  -- Copy filepath:line to clipboard
  vim.keymap.set('n', '<leader>yp', function()
    local filepath = vim.fn.expand("%:p")
    local line = vim.api.nvim_win_get_cursor(0)[1]
    local location = filepath .. ":" .. line
    vim.fn.setreg("+", location)
    vim.notify("Copied: " .. location, vim.log.levels.INFO)
  end, { desc = "Copy filepath:line to clipboard" })

  -- Auto-format Go files on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      vim.cmd("GoFmt")
    end
  })

  -- Go-specific statusline integration
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.go",
    callback = function()
      if vim.fn.expand("%:e") == "go" then
        local pkg = vim.fn.systemlist("go list . 2>/dev/null | xargs basename")
        if #pkg > 0 and pkg[1] ~= "" and pkg[1] ~= "." then
          local pkg_name = pkg[1]
          vim.api.nvim_buf_set_var(0, "go_package_name", pkg_name)
        end
      end
    end
  })

  -- Go syntax highlighting improvements
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.go",
    callback = function()
      -- Enhanced Go syntax features
      vim.cmd([[
        syn match goVarDecl /\v\w+(\s+|\s*:\=)/
        syn match goError /\<error\>/
        syn match goBool /\<\(true\|false\)\>/
      ]])
    end
  })

  -- Quick Go command shortcuts
  vim.api.nvim_create_user_command("GoRun", function(args)
    local file = vim.fn.expand("%")
    if file == "" then
      vim.notify("No file to run", vim.log.levels.ERROR)
      return
    end
    local cmd = "go run " .. file
    if #args.args > 0 then
      cmd = cmd .. " " .. args.args
    end
    vim.fn.jobstart(cmd, {
      on_exit = function(job, code)
        if code ~= 0 then
          vim.notify("Go run failed with exit code " .. code, vim.log.levels.ERROR)
        end
      end
    })
  end, { nargs = "*", complete = "shellcmd" })

  vim.api.nvim_create_user_command("GoBuild", function(args)
    local cmd = "go build"
    if #args.args > 0 then
      cmd = cmd .. " " .. args.args
    else
      cmd = cmd .. " ."
    end
    vim.fn.jobstart(cmd, {
      on_exit = function(job, code)
        if code ~= 0 then
          vim.notify("Go build failed with exit code " .. code, vim.log.levels.ERROR)
        else
          vim.notify("Go build successful", vim.log.levels.INFO)
        end
      end
    })
  end, { nargs = "*", complete = "shellcmd" })

  -- Enhanced Go test runner
  vim.api.nvim_create_user_command("GoTest", function(args)
    local cmd = "go test -v"
    if #args.args > 0 then
      cmd = cmd .. " " .. args.args
    end
    vim.cmd("!" .. cmd)
  end, { nargs = "*", complete = "shellcmd" })

  -- Toggle test coverage
  vim.api.nvim_create_user_command("GoCoverage", function()
    local cov_file = "coverage.out"
    vim.fn.jobstart("go test -coverprofile=" .. cov_file, {
      on_exit = function()
        if vim.fn.filereadable(cov_file) == 1 then
          vim.cmd("GoCoverageToggle")
          vim.notify("Coverage profile generated: " .. cov_file, vim.log.levels.INFO)
        end
      end
    })
  end, {})

  -- Import organization
  vim.api.nvim_create_user_command("GoImports", function()
    local current_file = vim.fn.expand("%")
    if current_file ~= "" then
      vim.fn.jobstart("goimports -w " .. current_file, {
        on_exit = function(job, code)
          if code == 0 then
            vim.cmd("edit!")
            vim.notify("Imports organized successfully", vim.log.levels.INFO)
          else
            vim.notify("Failed to organize imports", vim.log.levels.ERROR)
          end
        end
      })
    end
  end, {})

  -- Go module management
  vim.api.nvim_create_user_command("GoModTidy", function()
    vim.fn.jobstart("go mod tidy", {
      on_exit = function(job, code)
        if code == 0 then
          vim.notify("go.mod tidied successfully", vim.log.levels.INFO)
        else
          vim.notify("Failed to tidy go.mod", vim.log.levels.ERROR)
        end
      end
    })
  end, {})

  -- Error handling helper
  vim.api.nvim_create_user_command("GoIfErr", function()
    local line = vim.api.nvim_get_current_line()
    local error_var = "err"
    if line:match("local%s+([a-zA-Z_][a-zA-Z0-9_]*)%s*=%s*") then
      error_var = line:match("local%s+([a-zA-Z_][a-zA-Z0-9_]*)%s*=%s*") or "err"
    end
    local template = [[
if %s != nil {
	return %s
}
]]
    local insertion = string.format(template, error_var, error_var)
    vim.api.nvim_put({insertion}, "l", true, true)
  end, {})
end

return M