-- используется для быстрого перемещения до отдельно WARN и ERROR
-- local diagnostic_goto = function(next, severity)
--     local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
--     severity = severity and vim.diagnostic.severity[severity] or nil
--     return function()
--         go({ severity = severity })
--     end
-- end
--
-- настройка lsp с помощью lspconfig и cmp-nvim-lsp - простая настройка + добавление новых серверов
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/hrsh7th/cmp-nvim-lsp
return {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "mfussenegger/nvim-jdtls"
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
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
                -- change the Diagnostic symbols in the sign column (gutter)
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
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
            codelens = {
                enable = true,
            },
            -- Enable lsp cursor word highlighting
            document_highlight = {
                enable = true
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
            setup = {
            },
        }
    end,
    config = function(_, opts)
        vim.diagnostic.config(opts.diagnostics)
        -- vim.lsp.inlay_hint.enable(true, opts.inlay_hints)

        local lspconfig = require("lspconfig");
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- то, что должно быть в opts
        -- https://neovim.io/doc/user/map.html#%3Amap-arguments
        local options = {}

        -- Функция on_attach используется тут для настройки сочетаний клавиш после того,
        -- как языковой сервер подключается к текущему буферу
        local on_attach = function(_, bufnr)
            options.buffer = bufnr

            local builtin = require('telescope.builtin')

            -- show defenitions, references
            options.desc = "Show LSP references"
            vim.keymap.set("n", "gr", builtin.lsp_references, options)

            -- go to declaration
            options.desc = "Go to declaration"
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, options)

            -- show lsp definitions
            options.desc = "Show LSP definitions"
            vim.keymap.set("n", "gd", builtin.lsp_definitions, options)

            -- show lsp implementations
            options.desc = "Show LSP implementations"
            vim.keymap.set("n", "gi", builtin.lsp_implementations, options)

            -- show lsp type definitions
            options.desc = "Show LSP type definitions"
            vim.keymap.set("n", "gt", builtin.lsp_type_definitions, options)

            -- smart rename
            options.desc = "Smart rename"
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options)

            -- show buffer diagnostics for file
            options.desc = "Show file's diagnostics"
            vim.keymap.set("n", "<leader>D", builtin.diagnostics, options)

            -- show buffer diagnostics for line
            options.desc = "Show line's diagnostics"
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, options)

            -- show documentation for object under cursor
            options.desc = "Show documentation for object under cursor"
            vim.keymap.set("n", "K", vim.lsp.buf.hover, options)

            -- restart lsp
            options.desc = "Restart LSP"
            vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", options)
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()
        --
        -- https://github.com/golang/tools/tree/master/gopls
        lspconfig["gopls"].setup({
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
                    }
                }
            }
        })

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    -- заставляем lsp узнавать "vim" глобальную переменную
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        -- заставляем lsp увидеть файлы времени исполнения
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        }
                    },
                    hint = {
                        enable = true,
                    },
                }
            }
        })

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

        lspconfig["jdtls"].setup({
            on_attach = on_attach,
        })
    end
}
