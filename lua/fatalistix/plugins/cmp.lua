local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

-- nvim-cmp
-- https://github.com/hrsh7th/nvim-cmp
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer', -- исходники для текста в буффере (sources for text in buffer)
        'hrsh7th/cmp-path', -- исходники для системных путей (sources for file system path)
        'onsails/lspkind.nvim', -- иконки как в vscode (vs-code like pictograms)
        'L3MON4D3/LuaSnip', -- движок сниппетов (snippet engine)
        'saadparwaiz1/cmp_luasnip', -- поддержка сниппетов с помощью cmp (for autocompletion)
    },
    opts = function()
        -- set highlight group
        -- https://neovim.io/doc/user/api.html#nvim_set_hl()
        vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

        local cmp = require('cmp')
        local defaults = require('cmp.config.default')()
        local lspkind = require('lspkind')
        local luasnip = require('luasnip')

        return {
            completion = {
                -- options for what is shown in completion suggestion:
                -- menu - shows a pop up menu with completion suggestion (default)
                -- menuone - shows a pop up menu with completion suggestion and selects one (default)
                -- preview - allows preview of selected completion without replacing it in buffer
                -- noinsert - selected will not automatically be inserted into buffer
                -- noselect - shows a pop up menu with completion suggestion, but does not selects automatically
                completeopt = 'menu,preview,noinsert,noselect',
            },
            mapping = cmp.mapping.preset.insert({
                -- behavior can be one of:
                -- cmp.SelectBehavior.Insert: Inserts the text at cursor.
                -- cmp.SelectBehavior.Select: Only selects the text, potentially adds ghost_text at cursor
                -- :help cmp.select_next_item
                -- ["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if #cmp.get_entries() == 1 then
                            cmp.confirm({ select = true })
                        else
                            cmp.select_next_item()
                        end
                    elseif has_words_before() then
                        cmp.complete()
                        if #cmp.get_entries() == 1 then
                            cmp.confirm({ select = true })
                        end
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                -- ["<C-Space>"] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                -- If you didn't select any item and the option table contains select = true,
                -- nvim-cmp will automatically select the first item
                -- You can control how the completion item is injected into the
                -- file through the behavior option:
                -- 1) cmp.ConfirmBehavior.Insert - inserts the selected item and moves adjacent text to the right (default)
                -- 2) cmp.ConfirmBehavior.Replace - replaces adjacent text with selected item
                -- Accept currently selected item. Set `select` to `false`
                -- to only confirm explicitly selected items
                ['<CR>'] = cmp.mapping.confirm({
                    select = false,
                }),
                ['<C-l>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
                -- Accept currently selected item. Set `select` to `false`
                -- to only confirm explicitly selected items
                -- ["<S-CR>"] = cmp.mapping.confirm({
                -- behavior = cmp.ConfirmBehavior.Replace,
                -- select = true,
                -- }),
                -- ["<C-CR>"] = function(fallback)
                -- closes cmp completion menu with restoring the current line to the state before
                -- the current completion was started.
                -- cmp.abort()
                -- fallback()
                -- end,
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp', priority = 100 },
                { name = 'codeium', priority = 90 },
                { name = 'luasnip', priority = 80 },
                { name = 'path', priority = 70 },
                { name = 'buffer', priority = 60 },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = '...',
                    symbol_map = {
                        Array = '󰅪',
                        Boolean = '⊨',
                        Class = '󰌗',
                        Codeium = '',
                        Constructor = '',
                        Key = '󰌆',
                        Namespace = '󰅪',
                        Null = 'NULL',
                        Number = '#',
                        Object = '󰀚',
                        Package = '󰏗',
                        Property = '',
                        Reference = '',
                        Snippet = '',
                        String = '󰀬',
                        TypeParameter = '󰊄',
                        Unit = '',
                    },
                }),
            },
            experimental = {
                ghost_text = {
                    hl_group = 'CmpGhostText',
                },
            },
            sorting = defaults.sorting,
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = {
                    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
                    border = 'rounded',
                },
            },
            view = {
                entries = {
                    name = 'custom',
                    selection_order = 'top_down',
                },
            },
        }
    end,
    -- @param opts cmp.ConfigSchema
    config = function(_, opts)
        for _, source in ipairs(opts.sources) do
            source.group_index = source.group_index or 1
        end
        require('cmp').setup(opts)
    end,
}
