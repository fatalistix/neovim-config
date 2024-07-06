-- formatting
-- https://github.com/stevearc/conform.nvim
return {
    'stevearc/conform.nvim',
    lazy = true,
    cmd = 'ConformInfo',
    config = function()
        require('conform').setup({
            -- настройка форматтеров под каждый файл
            formatters_by_ft = {
                lua = { 'stylua' },
                -- conform применит множество форматтеров последовательно
                -- чтобы вызвать один из доступных нужно сделать так:
                -- go = { { "goimports", "gofmt" } }
                go = { 'goimports-reviser', 'golines', 'gofumpt' },
                -- Use a sub-list to run only the first available formatter
                -- javascript = { { "prettierd", "prettier" } },
                -- You can use a function here to determine the formatters dynamically
                -- python = function(bufnr)
                --     if require("conform").get_formatter_info("ruff_format", bufnr).available then
                --         return { "ruff_format" }
                --     else
                --         return { "isort", "black" }
                --     end
                -- end,
                -- Use the "*" filetype to run formatters on all filetypes.
                -- ["*"] = { "codespell" },
                -- Use the "_" filetype to run formatters on filetypes that don't
                -- have other formatters configured.
                -- ["_"] = { "trim_whitespace" },
            },
            -- If this is set, Conform will run the formatter on save.
            -- It will pass the table to conform.format().
            -- This can also be a function that returns the table.
            format_on_save = {
                -- Рекомендовано автором
                lsp_fallback = true,
                timeout_ms = 500,
            },
            -- If this is set, Conform will run the formatter asynchronously after save.
            -- It will pass the table to conform.format().
            -- This can also be a function that returns the table.
            format_after_save = {
                lsp_fallback = true,
            },
            -- Set the log level. Use `:ConformInfo` to see the location of the log file.
            log_level = vim.log.levels.ERROR,
            -- Conform will notify you when a formatter errors
            notify_on_error = true,
            -- Custom formatters and changes to built-in formatters
            -- Больше информации на github странице разработчика
            formatters = {},
        })

        -- Можно поставить formatters_by_ft и formatters напрямую
        -- require("conform").formatters_by_ft.lua = { "stylua" }
        -- require("conform").formatters.my_formatter = {
        --     command = "my_cmd"
        -- }
    end,
}
