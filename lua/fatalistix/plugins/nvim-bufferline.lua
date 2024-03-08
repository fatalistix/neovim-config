-- отображение буфферов (табов) в верхнем горизонтальном меню
-- https://github.com/akinsho/bufferline.nvim
return {
    'akinsho/bufferline.nvim',
    version = "*",
    event= "VeryLazy",
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
        { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
        { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
        { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
        { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
        { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    },
    config = function ()
        require("bufferline").setup({
            options = {
                close_command = function(n) require("mini.bufremove").delete(n, false) end,
                right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
                always_show_bufferline = false,
                separator_style = "slope",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "NvimTree",
                        highlight = "Directory",
                        separator = true,
                        text_align = "left",
                    }
                }
            },
        })
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd("BufAdd", {
            callback = function()
                vim.schedule(function()
                    pcall(nvim_bufferline)
                end)
            end,
        })
    end
}
