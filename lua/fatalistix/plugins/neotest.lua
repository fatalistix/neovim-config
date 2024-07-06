-- фреймворк для проведения тестирования
-- Testing framework
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

        vim.keymap.set('n', '<leader>nt', function()
            neotest.run.run()
        end, { desc = "Neotest run nearest test" })

        vim.keymap.set('n', '<leader>nf', function()
            neotest.run.run(vim.fn.expand("%"))
        end, { desc = "Neotest current file" })

        vim.keymap.set('n', '<leader>nx', function()
            neotest.run.stop()
        end, { desc = "Neotest stop" })

        vim.keymap.set('n', '<leader>no', function()
            neotest.output_panel.toggle()
        end, { desc = "Neotest toggle output" })

        vim.keymap.set('n', '<leader>ns', function()
            neotest.summary.toggle()
        end, { desc = "Neotest toggle summary" })

        vim.keymap.set('n', '<leader>nd', function()
            neotest.run.run({ strategy = "dap" })
        end, { desc = "Neotest debug nearest test" })

        vim.keymap.set('n', '<leader>na', function()
            neotest.run.attach()
        end, { desc = "Neotest attach to nearest test" })
    end
}
