local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local fatalistix_group = augroup('fatalistix', {})
local yank_group = augroup('HighlightYank', {})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = augroup('checktime', {}),
    callback = function()
        if vim.o.buftype ~= 'nofile' then
            vim.cmd('checktime')
        end
    end,
})

-- highlight on yank
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

--remove all trailing whitespace on save
autocmd('BufWritePre', {
    group = fatalistix_group,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

-- remove auto commenting new lines
autocmd('BufEnter', {
    pattern = '*',
    callback = function()
        vim.opt.fo:remove('c')
        vim.opt.fo:remove('r')
        vim.opt.fo:remove('o')
    end,
})

-- go: format and organize imports on save
-- autocmd('BufWritePre', {
--     pattern = { '*.go' },
--     callback = function()
--         local params = vim.lsp.util.make_range_params()
--         params.context = { only = { 'source.organizeImports' } }
--         local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 5000)
--         for cid, res in pairs(result or {}) do
--             for _, r in pairs(res.result or {}) do
--                 if r.edit then
--                     local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or 'utf-16'
--                     vim.lsp.util.apply_workspace_edit(r.edit, enc)
--                 end
--             end
--         end
--         vim.lsp.buf.format({ async = false })
--     end,
-- })

-- Code lens auto activation for some events
-- autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
--     pattern = '*',
--     callback = function()
--         vim.lsp.codelens.refresh()
--     end,
-- })
