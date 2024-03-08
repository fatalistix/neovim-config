-- https://github.com/ray-x/lsp_signature.nvim
-- Отвечает за подсказки в сигнатуре функции
return {
    'ray-x/lsp_signature.nvim',
    event = "VeryLazy",
    config = function()
        require('lsp_signature').setup({
            floating_window = true,
            hint_prefix = ""
        })
    end
}
