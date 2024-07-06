local gopls = {}

local lspconfig = require('lspconfig')
local capabilities = require('fatalistix.plugins.lsp.util.capabilities')
local on_attach = require('fatalistix.plugins.lsp.util.on-attach')

function gopls.setup()
    -- https://github.com/golang/tools/tree/master/gopls
    lspconfig['gopls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            gopls = {
                gofumpt = true,
                codelenses = {
                    generate = true,
                    regenerate_cgo = true,
                    run_govulncheck = true,
                    tidy = true,
                    upgrade_dependency = true,
                    vendor = true,
                },
                semanticTokens = true,
                usePlaceholders = true,
                analyses = {
                    fieldalignment = true,
                    unusedvariable = true,
                    unusedwrite = true,
                    useany = true,
                    unusedresult = true,
                },
                staticcheck = true,
                hints = {
                    assignVariableTypes = true,
                    constantValues = true,
                },
            },
        },
    })
end

return gopls
