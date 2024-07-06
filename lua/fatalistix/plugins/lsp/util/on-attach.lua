-- Функция on_attach используется тут для настройки сочетаний клавиш после того,
-- как языковой сервер подключается к текущему буферу
-- on_attach is used for setting keymaps after a language server is attached
return function(_, bufnr)
    -- то, что должно быть в opts функции map
    -- https://neovim.io/doc/user/map.html#%3Amap-arguments
    local options = {}
    options.buffer = bufnr

    local builtin = require('telescope.builtin')

    -- show defenitions, references
    options.desc = 'Show LSP references'
    vim.keymap.set('n', 'gr', builtin.lsp_references, options)

    -- go to declaration
    options.desc = 'Go to declaration'
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, options)

    -- show lsp definitions
    options.desc = 'Show LSP definitions'
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, options)

    -- show lsp implementations
    options.desc = 'Show LSP implementations'
    vim.keymap.set('n', 'gi', builtin.lsp_implementations, options)

    -- show lsp type definitions
    options.desc = 'Show LSP type definitions'
    vim.keymap.set('n', 'gt', builtin.lsp_type_definitions, options)

    -- smart rename
    options.desc = 'Smart rename'
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, options)

    -- show buffer diagnostics for file
    options.desc = "Show file's diagnostics"
    vim.keymap.set('n', '<leader>D', builtin.diagnostics, options)

    -- show buffer diagnostics for line
    options.desc = "Show line's diagnostics"
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, options)

    -- show documentation for object under cursor
    options.desc = 'Show documentation for object under cursor'
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, options)

    -- restart lsp
    options.desc = 'Restart LSP'
    vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', options)
end
