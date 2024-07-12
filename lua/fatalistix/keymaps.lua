-- Move Lines
-- vim.keymap.set("n", "<C-J>", "<cmd>m .+1<cr>==", { desc = "Move down" })
-- vim.keymap.set("n", "<C-K>", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- vim.keymap.set("i", "<C-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.set("i", "<C-K>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- vim.keymap.set("v", "<C-J>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- vim.keymap.set("v", "<C-K>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
vim.keymap.set('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to other buffer' })
vim.keymap.set('n', '<leader>bD', '<cmd>:bd<cr>', { desc = 'Close buffer and window' })
vim.keymap.set('n', '<leader>bC', '<cmd>:bd<cr>', { desc = 'Close buffer and window' })

-- Clear search with <esc>
vim.keymap.set({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
vim.keymap.set(
    'n',
    '<leader>ur',
    '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
    { desc = 'Redraw / clear hlsearch / diff update' }
)

-- lazy
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- new file
vim.keymap.set('n', '<leader>fn', '<cmd>enew<cr>', { desc = 'New file' })

-- diagnostic
vim.keymap.set('n', '<leader>cl', '<cmd>lopen<cr>', { desc = 'Location list' })
vim.keymap.set('n', '<leader>cq', '<cmd>copen<cr>', { desc = 'Quickfix list' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line diagnostics' })

vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' })

local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
vim.keymap.set('n', ']d', diagnostic_goto(true), { desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', diagnostic_goto(false), { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next error' })
vim.keymap.set('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev error' })
vim.keymap.set('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next warning' })
vim.keymap.set('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev warning' })

-- Terminal Mappings
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter normal mode' })
-- vim.keymap.set('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Go to left window' })
-- vim.keymap.set('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Go to lower window' })
-- vim.keymap.set('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Go to upper window' })
-- vim.keymap.set('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Go to right window' })
vim.keymap.set('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide terminal' })
vim.keymap.set('t', '<c-_>', '<cmd>close<cr>', { desc = 'Ignore which-key' })

-- windows
vim.keymap.set('n', '<leader>ww', '<C-W>p', { desc = 'Other window', remap = true })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete window', remap = true })
vim.keymap.set('n', '<leader>w-', '<C-W>s', { desc = 'Split window below', remap = true })
vim.keymap.set('n', '<leader>w|', '<C-W>v', { desc = 'Split window right', remap = true })
vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split window below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split window right', remap = true })

-- tabs
vim.keymap.set('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last tab' })
vim.keymap.set('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First tab' })
vim.keymap.set('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', { desc = 'New tab' })
vim.keymap.set('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })
