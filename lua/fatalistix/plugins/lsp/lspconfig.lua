-- настройка lsp с помощью lspconfig и cmp-nvim-lsp - простая настройка + добавление новых серверов
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/hrsh7th/cmp-nvim-lsp
return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },
    opts = function()
        return {
            diagnostics = {
                underline = true,
                update_in_insert = true,
                virtual_text = {
                    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                    -- prefix = "icons",
                    spacing = 4,
                    source = 'if_many',
                    prefix = '●',
                },
                severity_sort = true,
                -- change the Diagnostic symbols in the sign column (gutter)
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = ' ',
                        [vim.diagnostic.severity.WARN] = ' ',
                        [vim.diagnostic.severity.HINT] = ' ',
                        [vim.diagnostic.severity.INFO] = ' ',
                    },
                },
            },
            -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the inlay hints.
            inlay_hints = {
                enable = false,
                -- exclude = { "vue" },
            },
            -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
            -- Be aware that you also will need to properly configure your LSP server to
            -- provide the code lenses.
            -- codelens = {
            --     enable = true,
            -- },
            -- Enable lsp cursor word highlighting
            document_highlight = {
                enable = true,
            },
            -- options for vim.lsp.buf.format
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            -- LSP Server Settings
            ---@type lspconfig.options
            -- servers = {
            --
            -- },
            setup = {},
        }
    end,
    config = function(_, opts)
        vim.diagnostic.config(opts.diagnostics)
        -- vim.lsp.inlay_hint.enable(true, opts.inlay_hints)

        -- highlight groups for code lens
        vim.api.nvim_set_hl(0, 'LspCodeLens', { link = 'WarningMsg', default = true })
        vim.api.nvim_set_hl(0, 'LspCodeLensText', { link = 'WarningMsg', default = true })
        vim.api.nvim_set_hl(0, 'LspCodeLensSign', { link = 'WarningMsg', default = true })
        vim.api.nvim_set_hl(0, 'LspCodeLensSeparator', { link = 'Boolean', default = true })

        require('fatalistix.plugins.lsp.lang').setup()

        -- vim.api.nvim_echo({ { vim.inspect( some_long_object) } }, true, {})
    end,
}
