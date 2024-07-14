-- usage/implementations/definitions symbols
-- https://github.com/Wansmer/symbol-usage.nvim
return {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach', -- need run before LspAttach (so need to use `BufReadPre`) if you use nvim 0.9. On 0.10 use 'LspAttach'
    opts = function()
        local function text_format(symbol)
            local res = {}

            -- Indicator that shows if there are any other symbols in the same line
            local stacked_functions_content = symbol.stacked_count > 0 and ('+%s'):format(symbol.stacked_count) or ''

            if symbol.references then
                local usage = symbol.references <= 1 and 'usage' or 'usages'
                local num = symbol.references == 0 and 'no' or symbol.references
                table.insert(res, { '', 'SymbolUsageRefRound' })
                table.insert(res, { '󰌹 ', 'SymbolUsageRef' })
                table.insert(res, { ('%s %s'):format(num, usage), 'SymbolUsageRef' })
                table.insert(res, { '', 'SymbolUsageRefRound' })
            end

            if symbol.definition then
                if #res > 0 then
                    table.insert(res, { ' ', 'NonText' })
                end
                table.insert(res, { '', 'SymbolUsageDefRound' })
                table.insert(res, { '󰳽 ', 'SymbolUsageDef' })
                table.insert(res, { symbol.definition .. ' defs', 'SymbolUsageContent' })
                table.insert(res, { '', 'SymbolUsageDefRound' })
            end

            if symbol.implementation then
                if #res > 0 then
                    table.insert(res, { ' ', 'NonText' })
                end
                table.insert(res, { '', 'SymbolUsageImplRound' })
                table.insert(res, { '󰡱 ', 'SymbolUsageImpl' })
                table.insert(res, { symbol.implementation .. ' impls', 'SymbolUsageContent' })
                table.insert(res, { '', 'SymbolUsageImplRound' })
            end

            if stacked_functions_content ~= '' then
                if #res > 0 then
                    table.insert(res, { ' ', 'NonText' })
                end
                table.insert(res, { '', 'SymbolUsageImplRound' })
                table.insert(res, { ' ', 'SymbolUsageImpl' })
                table.insert(res, { stacked_functions_content, 'SymbolUsageContent' })
                table.insert(res, { '', 'SymbolUsageImplRound' })
            end

            return res
        end

        return {
            text_format = text_format,
        }
    end,
    keys = {
        {
            '<leader>ou',
            function()
                require('symbol-usage').toggle()
            end,
            desc = 'Toggle symbol usage for buffer',
        },
        {
            '<leader>oU',
            function()
                require('symbol-usage').toggle_globally()
            end,
            desc = 'Toggle symbol usage globally',
        },
    },
}
