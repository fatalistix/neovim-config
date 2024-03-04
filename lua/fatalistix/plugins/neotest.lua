-- фреймворк для проведения тестирования
-- https://github.com/nvim-neotest/neotest
-- https://github.com/nvim-neotest/neotest-go
return {
    "nvim-neotest/neotest",
    event = "LspAttach",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-neotest/neotest-go",
        "rouge8/neotest-rust",
    },
    config = function()
        local neotest = require('neotest')

        neotest.setup({
            adapters = {
                require('neotest-go')({
                    experimental = {
                        test_table = true,
                    },
                    args = { "-v", "-count=1", "-timeout=60s" }
                })
            }
        })

        vim.keymap.set('n', '<leader>tt', function()
            neotest.run.run()
        end, { desc = "Neotest run nearest test" })

        vim.keymap.set('n', '<leader>tf', function()
            neotest.run.run(vim.fn.expand("%"))
        end, { desc = "Neotest current file" })

        vim.keymap.set('n', '<leader>tts', function()
            neotest.run.stop()
        end, { desc = "Neotest stop" })

        vim.keymap.set('n', '<leader>to', function()
            neotest.output_panel.open()
        end, { desc = "Neotest open output" })

        vim.keymap.set('n', '<leader>ts', function()
            neotest.summary.toggle()
        end, { desc = "Neotest toggle summary" })
    end
}