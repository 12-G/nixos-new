-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "nil_ls" }
local nvlsp = require "nvchad.configs.lspconfig"
local nvcap = nvlsp.capabilities

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvcap,
  }
end

-- configuring single server, example: typescript
lspconfig.basedpyright.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvcap,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true,
        reportMissingTypeStubs = false,
        diagnosticSeverityOverrides = {
          reportUnusedImport = "information",
          reportUnusedFunction = "information",
          reportUnusedVariable = "information",
          reportGeneralTypeIssues = "none",
          reportOptionalMemberAccess = "none",
          reportOptionalSubscript = "none",
          reportPrivateImportUsage = "none",
        },
      },
    },
  },
}
