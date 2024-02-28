-- дерево отката изменений 
-- https://github.com/mbbill/undotree
return {
    'mbbill/undotree', 
    config = function()
        vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
    end
}