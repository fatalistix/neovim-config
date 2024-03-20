-- Самый популярный набор утилит для разработки на golang
return {
    "ray-x/go.nvim",
    enabled = false,
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("go").setup({
        --     lsp_cfg = false,
        })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
}
