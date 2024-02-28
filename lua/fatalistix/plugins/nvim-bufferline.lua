-- отображение буфферов (табов) в верхнем горизонтальном меню
-- https://github.com/akinsho/bufferline.nvim
return {
    'akinsho/bufferline.nvim',
    enabled = false,
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function ()
        require("bufferline").setup({
            options = {
                separator_style = "slope",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        separator = true
                    }
                }
            },
        })
    end
}
