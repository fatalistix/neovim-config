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
    config = function()
        local lspconfig = require("lspconfig");
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        -- то, что должно быть в opts
        -- https://neovim.io/doc/user/map.html#%3Amap-arguments
        local opts = {}

        -- Функция on_attach используется тут для настройки сочетаний клавиш после того,
        -- как языковой сервер подключается к текущему буферу
        local on_attach = function(_, bufnr)
            opts.buffer = bufnr

            local builtin = require('telescope.builtin')

            -- show defenitions, references
            opts.desc = "Show LSP references"
            vim.keymap.set("n", "gR", builtin.lsp_references, opts)

            -- go to declaration
            opts.desc = "Go to declaration"
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            -- show lsp definitions
            opts.desc = "Show LSP definitions"
            vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)

            -- show lsp implementations
            opts.desc = "Show LSP implementations"
            vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)

            -- show lsp type definitions
            opts.desc = "Show LSP type definitions"
            vim.keymap.set("n", "gt", builtin.lsp_type_definitions, opts)

            -- see available code actions
            opts.desc = "See available code actions"
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

            -- smart rename
            opts.desc = "Smart rename"
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            -- show buffer diagnostics for file
            opts.desc = "Show file's diagnostics"
            vim.keymap.set("n", "<leader>D", builtin.diagnostics, opts)

            -- show buffer diagnostics for line
            opts.desc = "Show line's diagnostics"
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

            -- -- jump to prev diagnostic in buffer
            -- opts.desc = "Prev diagnostic"
            -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            --
            -- -- jump to next diagnostic in buffer
            -- opts.desc = "Next diagnostic"
            -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            --
            -- -- jump to prev error in buffer
            -- opts.desc = "Prev error"
            -- vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), opts)
            --
            -- -- jump to next error in buffer
            -- opts.desc = "Next error"
            -- vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), opts)
            --
            -- -- jump to prev warning in buffer
            -- opts.desc = "Prev warning"
            -- vim.keymap.set("n" ,"[w", diagnostic_goto(false, "WARN"), opts)
            --
            -- -- jump to next warning in buffer
            -- opts.desc = "Next warning"
            -- vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), opts)

            -- show documentation for object under cursor
            opts.desc = "Show documentation for object under cursor"
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

            -- restart lsp
            opts.desc = "Restart LSP"
            vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- change the Diagnostic symbols in the sign column (gutter)
        local signs = { Error = " ", Warn  = " ", Hint  = " ", Info  = " ", }
        for type, icon in pairs(signs) do
         local hl = "DiagnosticSign" .. type
         vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

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
                    },
                    staticcheck = true,
                    hints = {
                        assignVariableTypes = true,
                        constantValues = true,
                    }
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

        -- https://projects.eclipse.org/projects/eclipse.jdt.ls
        lspconfig["jdtls"].setup({
            on_attach = on_attach,
        })

        -- https://github.com/rust-lang/rust-analyzer
        lspconfig["rust_analyzer"].setup({
            on_attach = on_attach,
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
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        }
                    }
                }
            }
        })
    end
}
