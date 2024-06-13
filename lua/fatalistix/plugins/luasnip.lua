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
    keys = {
        {
            "<tab>",
            function()
                return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end,
            expr = true, silent = true, mode = "i",
        },
        { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function()
        require("luasnip").setup()
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
