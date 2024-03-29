-- фреймворк для проведения тестирования
-- https://github.com/nvim-neotest/neotest
-- https://github.com/nvim-neotest/neotest-go
return {
    "nvim-neotest/neotest",
    event = "LspAttach",
    dependencies = {
        -- required by default
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- debug adapter protocol
        "mfussenegger/nvim-dap",
        -- language specific dependencies
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

        vim.keymap.set('n', '<leader>tx', function()
            neotest.run.stop()
        end, { desc = "Neotest stop" })

        vim.keymap.set('n', '<leader>to', function()
            neotest.output_panel.open()
        end, { desc = "Neotest open output" })

        vim.keymap.set('n', '<leader>ts', function()
            neotest.summary.toggle()
        end, { desc = "Neotest toggle summary" })

        vim.keymap.set('n', '<leader>td', function()
            neotest.run.run({ strategy = "dap" })
        end, { desc = "Neotest debug nearest test" })

        vim.keymap.set('n', '<leader>ta', function()
            neotest.run.attach()
        end, { desc = "Neotest attach to nearest test" })
    end
}
