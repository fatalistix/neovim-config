-- дерево отката изменений
-- https://github.com/mbbill/undotree
return {
    'mbbill/undotree',
    config = function()
        vim.keymap.set('n', '<leader>ut', ":UndotreeToggle<CR>", { desc = "Toggle undotree" })
        vim.keymap.set('n', '<leader>uo', ":UndotreeShow<CR>", { desc = "Open undotree" })
        vim.keymap.set('n', '<leader>uc', ":UndotreeHide<CR>", { desc = "Close undotree" })
        vim.keymap.set('n', '<leader>uf', ":UndotreeFocus<CR>", { desc = "Focus undotree" })
    end
}
