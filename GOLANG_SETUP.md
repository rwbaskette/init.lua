# Modern Golang Tooling for Neovim

This configuration adds comprehensive modern Golang tooling to Neovim.

## Features Added

### 🎯 Go Language Server (gopls)
- Advanced code completion with `completeUnimported`
- Placeholder support for function parameters
- Static analysis for unused parameters and variables
- Code lenses for generate, test, and tidy operations
- Fuzzy matching for symbols and completion
- Semantic tokens for enhanced syntax highlighting

### 🧪 Go Testing
- **`<leader>gt`** - Run all tests in current package
- **`<leader>gT`** - Run test function under cursor
- **`<leader>gc`** - Toggle test coverage
- **`<leader>tt`** - Run tests with quickfix results

### 🔧 Go Development
- **`<leader>gr`** - Run current Go file
- **`<leader>gb`** - Build current Go package
- **`<leader>gd`** - Show Go documentation
- **`<leader>gf`** - Format Go code (gofumpt)
- **`<leader>gi`** - Organize imports (goimports)
- **`<leader>gm`** - Tidy go.mod
- **`<leader>ge`** - Add error checking boilerplate
- **`<leader>gg`** - Run go generate
- **`<leader>gp`** - Go to alternate file (.go ↔ _test.go)
- **`<leader>gs`** - Split window with alternate
- **`<leader>gv`** - Vertical split with alternate

### 🐛 Debugging (Delve DAP)
- **`<leader>dd`** - Start debugger
- **`<leader>dc`** - Continue execution
- **`<leader>ds`** - Step into function
- **`<leader>do`** - Step out of function
- **`<leader>db`** - Toggle breakpoint

### 📁 File Navigation
- **`<leader>gf`** - Find Go files in project
- **`<leader>gt`** - Find Go test files
- **`<leader>gm`** - Find go.mod file
- **`<leader>gw`** - Find Go functions/methods
- **`<leader>ge`** - Search Go workspace symbols

## Required Tools

Install these via Mason (run `:MasonInstall` in Neovim):
- `gopls` - Go language server
- `goimports` - Import organization
- `gotests` - Test generation
- `delve` - Debugger

Or install manually:
```bash
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/cweill/gotests@latest
go install github.com/go-delve/delve/cmd/dlv@latest
```

## Configuration Files

- `lua/rwb/go.lua` - Go utilities and commands
- `lua/rwb/lsp.lua` - Enhanced gopls configuration
- `lua/rwb/telescope.lua` - Go-specific file pickers
- `lua/rwb/lazy.lua` - Go plugins (go.nvim, nvim-go-ide)

## Custom Commands

- `:GoRun [args]` - Run current file with optional args
- `:GoBuild [args]` - Build package with optional args
- `:GoTest [args]` - Run tests with optional args
- `:GoCoverage` - Generate coverage profile
- `:GoImports` - Organize imports in current file
- `:GoModTidy` - Tidy go.mod dependencies
- `:GoIfErr` - Insert error checking boilerplate

## Go-specific Settings

- Tab width: 4 spaces
- Max line length: 120 characters
- JSON tags with `omitempty`
- Race detector enabled for tests
- 60 second test timeout
- Verbose test output

## Plugins Used

1. **ray-x/go.nvim** - Modern Go plugin with comprehensive features
2. **crispgm/nvim-go-ide** - IDE-like Go environment
3. **nvim-treesitter/nvim-treesitter** - Syntax highlighting
4. **mfussenegger/nvim-dap** - Debug adapter protocol
5. **williamboman/mason.nvim** - Tool management

## Usage Tips

1. **First time setup**: Run `:GoUpdateBinaries` to install/update Go tools
2. **Import issues**: Use `:GoImports` to fix import problems
3. **Debugging**: Set breakpoints with `<leader>db` and start debugging with `<leader>dd`
4. **Quick navigation**: Use telescope pickers (`<leader>gf`, `<leader>gw`, etc.) for fast file/symbol search
5. **Test coverage**: Toggle coverage view with `:GoCoverage` or `<leader>gc`

## Troubleshooting

If gopls doesn't start properly:
1. Run `:MasonInstall gopls` to ensure it's installed
2. Check `:LspInfo` for gopls status
3. Try `:e` to refresh and restart LSP
4. Check `:messages` for any errors

For DAP debugging issues:
1. Ensure `dlv` is installed via `:GoUpdateBinaries`
2. Check `:DapVirtualTextShow` for debug output
3. Verify launch configuration in `lua/rwb/go.lua`