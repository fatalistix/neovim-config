-- окно для быстрой навигации по файлу (классы, методы, константы и т. д.)
-- https://github.com/stevearc/aerial.nvim
return {
    'stevearc/aerial.nvim',
    -- Optional dependencies
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        attach_mode = 'global',
        backends = { 'lsp', 'treesitter', 'markdown', 'man' },
        layout = { min_width = 28 },
        show_guides = true,
        filter_kind = false,
        guides = {
            mid_item = '├ ',
            last_item = '└ ',
            nested_top = '│ ',
            whitespace = '  ',
        },
        keymaps = {
            ['[y'] = 'actions.prev',
            [']y'] = 'actions.next',
            ['[Y'] = 'actions.prev_up',
            [']Y'] = 'actions.next_up',
            ['<C-k>'] = 'actions.prev_up',
            ['<C-j>'] = 'actions.next_up',
            -- ['{'] = false,
            -- ['}'] = false,
            -- ['[['] = false,
            -- [']]'] = falset,
        },
        -- on_attach = function(bufnr)
        --     -- Jump forwards/backwards with '{' and '}'
        --     -- Прыгаем вперед и назад с помощью фигурных скобок
        --     vim.keymap.set("n", "[", aerial.prev, { buffer = bufnr })
        --     vim.keymap.set("n", "]", aerial.next, { buffer = bufnr })
        --     vim.keymap.set("n", "<C-k>", aerial.prev_up, { buffer = bufnr })
        --     vim.keymap.set("n", "<C-j>", aerial.next_up, { buffer = bufnr })
        -- end
    },

    config = function(_, opts)
        local aerial = require('aerial')
        aerial.setup(opts)

        -- Общие комбинации клавиш
        vim.keymap.set('n', '<leader>ac', aerial.close, { desc = 'Close' })
        vim.keymap.set('n', '<leader>ah', function()
            aerial.toggle({ direction = 'left' })
        end, { desc = 'Toggle left' })
        vim.keymap.set('n', '<leader>al', function()
            aerial.toggle({ direction = 'right' })
        end, { desc = 'Toggle right' })
        vim.keymap.set('n', '<leader>af', function()
            aerial.toggle({ direction = 'float' })
        end, { desc = 'Toggle float' })
        vim.keymap.set('n', '<esc>', function()
            aerial.close()
        end, { desc = 'Close aerial window' })
        -- Если надо, то toggle можно заменить на open
        -- vim.keymap.set('n', '<leader>ah', function() aerial.open({ direction="left" }) end, { desc = "Toggle left" })
        -- vim.keymap.set('n', '<leader>al', function() aerial.open({ direction="right" }) end, { desc = "Toggle right" })
        -- vim.keymap.set('n', '<leader>af', function() aerial.open({ direction="float" }) end, { desc = "Toggle float" })
    end,
}
