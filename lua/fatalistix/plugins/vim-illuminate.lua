-- подсветочка в стиле vscode и intellij - подсвечивает совпадающие с объектом под моим курсором сущности
-- https://github.com/RRethy/vim-illuminate
return {
    "RRethy/vim-illuminate",
    opts = {
        delay = 200,
        large_file_cutoff = 2000,
        large_file_overrides = {
            providers = { "lsp" },
        },
        filetypes_denylist = {
            'dirbuf',
            'dirvish',
            'fugitive',
            'NvimTree',
        },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)

        local function map(key, dir, buffer)
            vim.keymap.set("n", key, function()
                require("illuminate")["goto_" .. dir .. "_reference"](false)
            end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " reference", buffer = buffer })
        end

        map("]r", "next")
        map("[r", "prev")

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local buffer = vim.api.nvim_get_current_buf()
                map("]r", "next", buffer)
                map("[r", "prev", buffer)
            end,
        })
    end,
}
