-- движок сниппетов для lua
-- https://github.com/L3MON4D3/LuaSnip
return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets", -- полезные сниппеты (useful snippets)
    },
    opts = {
        history = true,
        updateevents = "TextChanged,TextChangedI",
    },
    config = function()
        require("luasnip").setup()
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
