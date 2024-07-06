-- Всплывающий текст во время дебаггинга
-- способен показывать текущие значения переменных + причину завершения работы
return {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'mfussenegger/nvim-dap',
    },
    opts = {},
}
