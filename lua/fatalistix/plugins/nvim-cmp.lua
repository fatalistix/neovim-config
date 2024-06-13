-- nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer", -- исходники для текста в буффере (sources for text in buffer)
        "hrsh7th/cmp-path",   -- исходники для системных путей (sources for file system path)
        "onsails/lspkind.nvim", -- иконки как в vscode (vs-code like pictograms)
        "L3MON4D3/LuaSnip",   -- движок сниппетов (snippet engine)
        "saadparwaiz1/cmp_luasnip", -- поддержка сниппетов с помощью cmp (for autocompletion)
    },
    opts = function()
        -- set highlight group
        -- https://neovim.io/doc/user/api.html#nvim_set_hl()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
        local defaults = require("cmp.config.default")()
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")
        -- require("luasnip.loaders.from_vscode").lazy_load()

        return {
            completion = {
                -- options for what is shown in completion suggestion:
                -- menu - shows a pop up menu with completion suggestion (default)
                -- menuone - shows a pop up menu with completion suggestion and selects one (default)
                -- preview - allows preview of selected completion without replacing it in buffer
                -- noinsert - selected will not automatically be inserted into buffer
                -- noselect - shows a pop up menu with completion suggestion, but does not selects automatically
                completeopt = "menu,preview,noinsert,noselect"
            },
            mapping = cmp.mapping.preset.insert({
                -- behavior can be one of:
                -- cmp.SelectBehavior.Insert: Inserts the text at cursor.
                -- cmp.SelectBehavior.Select: Only selects the text, potentially adds ghost_text at cursor
                -- :help cmp.select_next_item
                ["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                -- If you didn't select any item and the option table contains select = true,
                -- nvim-cmp will automatically select the first item
                -- You can control how the completion item is injected into the
                -- file through the behavior option:
                -- 1) cmp.ConfirmBehavior.Insert - inserts the selected item and moves adjacent text to the right (default)
                -- 2) cmp.ConfirmBehavior.Replace - replaces adjacent text with selected item
                -- Accept currently selected item. Set `select` to `false`
                -- to only confirm explicitly selected items
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
                -- Accept currently selected item. Set `select` to `false`
                -- to only confirm explicitly selected items
                ["<S-CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                ["<C-CR>"] = function(fallback)
                    -- closes cmp completion menu with restoring the current line to the state before
                    -- the current completion was started.
                    cmp.abort()
                    fallback()
                end,
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer" },
                { name = "crates" },
                { name = "codeium" },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                })
            }
            ,
            experimental = {
                ghost_text = {
                    hl_group = "CmpGhostText"
                },
            },
            sorting = defaults.sorting,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            }
        }
    end,
    -- config = function()
    --     local cmp = require("cmp")
    --     local luasnip = require("luasnip")
    --     local lspkind = require("lspkind")
    --
    --     -- loads vscode style snippets from installed plugins (e. g. friendly-snippets)
    --     require("luasnip.loaders.from_vscode").lazy_load()
    --
    --     cmp.setup({
    --         -- completion = {
    --         --     completeopt = "menu,menuone,preview,noselect",
    --         -- },
    --         snippet = {
    --             expand = function(args)
    --                 luasnip.lsp_expand(args.body)
    --             end,
    --         },
    --         mapping = cmp.mapping.preset.insert({
    --             ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    --             ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    --             ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    --             ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --             ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestion
    --             ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    --             ["<CR>"] = cmp.mapping.confirm(),
    --         }),
    --
    --         -- sources for autocompletion
    --         sources = cmp.config.sources({
    --             { name = "nvim_lsp" },
    --             { name = "luasnip" }, -- snippets
    --             { name = "buffer" }, -- text within current buffer
    --             { name = "path" }, -- file system paths
    --         }),
    --
    --         formatting = {
    --             format = lspkind.cmp_format({
    --                 maxwidth = 50,
    --                 ellipsis_char = "...",
    --             }),
    --         },
    --     })
    -- end

    -- @param opts cmp.ConfigSchema
    config = function(_, opts)
        for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
        end
        require("cmp").setup(opts)

        -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        --     vim.lsp.diagnostic.on_publish_diagnostics, {
        --         -- delay update diagnostics
        --         update_in_insert = true,
        --     }
        -- )
    end,
}
