-- с помощью этого можно редактировать vim используя... vim!!!
-- https://github.com/folke/neodev.nvim
return {
    'folke/neodev.nvim',
    opts = {
        library = {
            types = true,
            plugins = {
                'nvim-treesitter',
                'plenary.nvim',
                'telescope.nvim',
                'nvim-dap-ui',
            },
        },
    },
}
