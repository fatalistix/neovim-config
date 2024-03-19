-- окно для быстрой навигации по файлу (классы, методы, константы и т. д.)
-- https://github.com/stevearc/aerial.nvim
return {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local aerial = require('aerial')
        aerial.setup({
            layout = {
                width = 28,
            },
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                -- Прыгаем вперед и назад с помощью фигурных скобок
                vim.keymap.set("n", "[", aerial.prev, { buffer = bufnr })
                vim.keymap.set("n", "]", aerial.next, { buffer = bufnr })
                vim.keymap.set("n", "{", aerial.prev_up, { buffer = bufnr })
                vim.keymap.set("n", "}", aerial.next_up, { buffer = bufnr })
            end
        })

        -- Общие комбинации клавиш
        vim.keymap.set('n', '<leader>ac', aerial.close, { desc = "Close" })
        vim.keymap.set('n', '<leader>ah', function() aerial.toggle({ direction="left" }) end, { desc = "Toggle left" })
        vim.keymap.set('n', '<leader>al', function() aerial.toggle({ direction="right" }) end, { desc = "Toggle right" })
        vim.keymap.set('n', '<leader>af', function() aerial.toggle({ direction="float" }) end, { desc = "Toggle float" })
        -- Если надо, то toggle можно заменить на open
        -- vim.keymap.set('n', '<leader>ah', function() aerial.open({ direction="left" }) end, { desc = "Toggle left" })
        -- vim.keymap.set('n', '<leader>al', function() aerial.open({ direction="right" }) end, { desc = "Toggle right" })
        -- vim.keymap.set('n', '<leader>af', function() aerial.open({ direction="float" }) end, { desc = "Toggle float" })
    end
}
