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
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, options)

    -- show buffer diagnostics for file
    options.desc = "Show file's diagnostics in telescope"
    vim.keymap.set('n', '<leader>cD', builtin.diagnostics, options)

    -- show buffer diagnostics for line
    options.desc = "Show line's diagnostics as float"
    vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, options)

    -- show documentation for object under cursor
    options.desc = 'Show documentation for object under cursor'
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, options)

    -- restart lsp
    options.desc = 'Restart LSP'
    vim.keymap.set('n', '<leader>cc', ':LspRestart<CR>', options)

    -- location list
    options.desc = 'Location list'
    vim.keymap.set('n', '<leader>cl', '<cmd>lopen<cr>', options)

    -- quickfix list
    options.desc = 'Quickfix list'
    vim.keymap.set('n', '<leader>cq', '<cmd>copen<cr>', options)

    -- next and previous quickfix
    options.desc = 'Previous quickfix'
    vim.keymap.set('n', '[q', vim.cmd.cprev, options)
    options.desc = 'Next quickfix'
    vim.keymap.set('n', ']q', vim.cmd.cnext, options)

    local diagnostic_goto = function(next, severity)
        local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
        severity = severity and vim.diagnostic.severity[severity] or nil
        return function()
            go({ severity = severity })
        end
    end

    -- next diagnostic/error/warning
    options.desc = 'Next diagnostic'
    vim.keymap.set('n', ']d', diagnostic_goto(true), options)
    options.desc = 'Prev diagnostic'
    vim.keymap.set('n', '[d', diagnostic_goto(false), options)
    options.desc = 'Next error'
    vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), options)
    options.desc = 'Prev error'
    vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), options)
    options.desc = 'Next warning'
    vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), options)
    options.desc = 'Prev warning'
    vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), options)
end
