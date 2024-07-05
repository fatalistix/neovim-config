local clangd = {}

local lspconfig = require("lspconfig");
local capabilities = require('fatalistix.plugins.lsp.util.capabilities')
local on_attach = require('fatalistix.plugins.lsp.util.on-attach')

function clangd.setup()
    -- https://clangd.llvm.org/installation#compile_commandsjson
    -- https://clang.llvm.org/docs/ClangCommandLineReference.html
    lspconfig["clangd"].setup({
        on_attach = on_attach,
        cmd = {
            "clangd",
            "-log=error",
            "--background-index",
            "--limit-results=500",
            "--completion-style=detailed",
        }
    })
end

return clangd
