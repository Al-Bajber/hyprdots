-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers =
  { "html", "cssls", "intelephense", "clangd", "pyright", "jdtls", "kotlin_language_server", "tailwindcss" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.ts_ls.setup { -- Note: Still uses tsserver internally
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  init_options = {
    preferences = {
      includeCompletionsForImportStatements = true,
      includeAutomaticOptionalChainCompletions = true,
      includeCompletionsWithSnippetText = true,
      allowJs = true,
      jsx = "preserve",
    },
    compilerOptions = {
      jsx = "react-jsx", -- For React 17+ automatic JSX transform
    },
  },
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
