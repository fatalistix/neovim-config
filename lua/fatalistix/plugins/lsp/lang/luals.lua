local luals = {}

local lspconfig = require('lspconfig')
local capabilities = require('fatalistix.plugins.lsp.util.capabilities')
local on_attach = require('fatalistix.plugins.lsp.util.on-attach')

function luals.setup()
    lspconfig['lua_ls'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                -- заставляем lsp узнавать "vim" глобальную переменную
                diagnostics = {
                    globals = { 'vim' },
                },
                workspace = {
                    -- заставляем lsp увидеть файлы времени исполнения
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                        [vim.fn.stdpath('config') .. '/lua'] = true,
                    },
                },
                hint = {
                    enable = true,
                },
            },
        },
    })
end

return luals
