local function is_buffer_unnamed_and_empty(bufnr)
    if vim.api.nvim_get_option_value('buflisted', { buf = bufnr }) and not vim.api.nvim_get_option_value('readonly', { buf = bufnr }) then
        if vim.api.nvim_buf_get_name(bufnr) ~= '' then
            return false -- there is a buffer with a name
        end
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        if #lines > 1 or (#lines == 1 and #lines[1] > 0) then
            return false -- there is a buffer with content
        end
    end
    return true -- there are no listed, writable, named, nonempty buffers
end

-- отображение буфферов (табов) в верхнем горизонтальном меню
-- https://github.com/akinsho/bufferline.nvim
return {
    'akinsho/bufferline.nvim',
    version = "*",
    event = "VeryLazy",
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
        { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
        { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
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
                        separator = true,
                        text_align = "center",
                    },
                    {
                        filetype = "aerial",
                        text = "Aerial",
                        separator = true,
                        text_align = "center",
                    }
                }
            },
        })

        -- Fix bufferline when restoring a session
        -- vim.api.nvim_create_autocmd("BufAdd", {
        --     callback = function()
        --         vim.schedule(function()
        --             pcall(nvim_bufferline)
        --         end)
        --     end,
        -- })
    end
}
