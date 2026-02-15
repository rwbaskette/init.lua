---
-- LSP setup
---

-- DON'T FORGET TO INSTALL LANGUAGE SERVERS
-- MasonInstall
--    typescript-language-server
--    eslint_d
--    goimports
--    gopls
--    lua-language-server
--    gotests
--    delve


-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- Go specific setup
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4

    -- Go-specific keybindings
    vim.keymap.set('n', '<leader>gr', '<cmd>GoRun<CR>', { buffer = true, desc = "Run Go file" })
    vim.keymap.set('n', '<leader>gb', '<cmd>GoBuild<CR>', { buffer = true, desc = "Build Go package" })
    vim.keymap.set('n', '<leader>gt', '<cmd>GoTest<CR>', { buffer = true, desc = "Run Go tests" })
    vim.keymap.set('n', '<leader>gT', '<cmd>GoTestFunc<CR>', { buffer = true, desc = "Run Go test function" })
    vim.keymap.set('n', '<leader>gc', '<cmd>GoCoverage<CR>', { buffer = true, desc = "Toggle test coverage" })
    vim.keymap.set('n', '<leader>gd', '<cmd>GoDoc<CR>', { buffer = true, desc = "Show Go documentation" })
    vim.keymap.set('n', '<leader>gf', '<cmd>GoFmt<CR>', { buffer = true, desc = "Format Go code" })
    vim.keymap.set('n', '<leader>gi', '<cmd>GoImports<CR>', { buffer = true, desc = "Organize Go imports" })
    vim.keymap.set('n', '<leader>gm', '<cmd>GoModTidy<CR>', { buffer = true, desc = "Tidy go.mod" })
    vim.keymap.set('n', '<leader>ge', '<cmd>GoIfErr<CR>', { buffer = true, desc = "Add error check" })
    vim.keymap.set('n', '<leader>gg', '<cmd>GoGenerate<CR>', { buffer = true, desc = "Run go generate" })
    vim.keymap.set('n', '<leader>gp', '<cmd>GoAlt<CR>', { buffer = true, desc = "Go to alternate file" })
    vim.keymap.set('n', '<leader>gs', '<cmd>GoSplit<CR>', { buffer = true, desc = "Split window with alternate" })
    vim.keymap.set('n', '<leader>gv', '<cmd>GoVsplit<CR>', { buffer = true, desc = "Vsplit window with alternate" })

    -- DAP keybindings for Go
    vim.keymap.set('n', '<leader>dd', '<cmd>lua require("dap").continue()<CR>', { buffer = true, desc = "Start debugger" })
    vim.keymap.set('n', '<leader>dc', '<cmd>lua require("dap").continue()<CR>', { buffer = true, desc = "Continue" })
    vim.keymap.set('n', '<leader>ds', '<cmd>lua require("dap").step_over()<CR>', { buffer = true, desc = "Step over" })
    vim.keymap.set('n', '<leader>di', '<cmd>lua require("dap").step_into()<CR>', { buffer = true, desc = "Step into" })
    vim.keymap.set('n', '<leader>do', '<cmd>lua require("dap").step_out()<CR>', { buffer = true, desc = "Step out" })
    vim.keymap.set('n', '<leader>db', '<cmd>lua require("dap").toggle_breakpoint()<CR>', { buffer = true, desc = "Toggle breakpoint" })
    vim.keymap.set('n', '<leader>dr', '<cmd>lua require("dap").repl.toggle()<CR>', { buffer = true, desc = "Toggle REPL" })
    vim.keymap.set('n', '<leader>dq', '<cmd>lua require("dap").close()<CR>', { buffer = true, desc = "Close debugger" })
  end
})

-- Go test results quickfix
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.keymap.set('n', '<leader>tt', function()
      local ok, result = pcall(vim.cmd, "GoTest -v")
      if ok then
        vim.cmd("copen")
      end
    end, { buffer = true, desc = "Run tests and show results" })
  end
})

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      local lsp_opt = {}
      if server_name == "gopls" then
        lsp_opt = {
          settings = {
            gopls = {
              gofumpt = true,
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
                unusedvariable = true,
                unreachable = true,
              },
              staticcheck = true,
              codelenses = {
                generate = true,
                gc_details = true,
                test = true,
                tidy = true,
              },
              diagnostic = {
                setFlags = "default",
              },
              formatting = {
                gofumpt = true,
                ["local"] = "",
              },
              imports = {
                goimports = true,
              },
              matcher = "Fuzzy",
              symbolMatcher = "fuzzy",
              semanticTokens = true,
            }
          }
        }
      elseif server_name == "lua_ls" then
        lsp_opt = {
          settings = {
            Lua = {
              completion = {
                callSnippet = "Replace"
              },
              diagnostics = {
                globals = {"vim", "go"}
              }
            }
          }
        }
      end
      require('lspconfig')[server_name].setup(lsp_opt)
    end,
  }
})

---
-- Autocompletion config
---
local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})
