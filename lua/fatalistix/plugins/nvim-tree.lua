-- древовидное представление каталогов
-- https://github.com/nvim-tree/nvim-tree.lua
return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    opts = function()
        local on_attach = function(bufnr)
            local api = require('nvim-tree.api')
            -- local preview = require('nvim-tree-preview')

            local function opts(desc)
                return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            local git_add = function()
                local node = api.tree.get_node_under_cursor()
                local gs = node.git_status.file

                -- If the current node is a directory get children status
                if gs == nil then
                    gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
                        or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
                end

                -- If the file is untracked, unstaged or partially staged, we stage it
                if gs == '??' or gs == 'MM' or gs == 'AM' or gs == ' M' then
                    vim.cmd('silent !git add ' .. node.absolute_path)

                -- If the file is staged, we unstage
                elseif gs == 'M ' or gs == 'A ' then
                    vim.cmd('silent !git restore --staged ' .. node.absolute_path)
                end

                api.tree.reload()
            end

            local function edit_or_open()
                local node = api.tree.get_node_under_cursor()

                if node.nodes ~= nil then
                    -- expand or collapse folder
                    api.node.open.edit()
                else
                    -- open file
                    api.node.open.edit()
                end
            end

            local function edit_and_close_tree_or_open()
                local node = api.tree.get_node_under_cursor()

                if node.nodes ~= nil then
                    -- expand or collapse folder
                    api.node.open.edit()
                else
                    -- open file
                    api.node.open.edit()
                    -- Close the tree if file was opened
                    api.tree.close()
                end
            end

            -- preview node
            -- local function preview_node()
            --     -- preview file using plugin
            --     preview.node_under_cursor({ toggle_focus = true })
            --     preview.watch()
            -- end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set('n', 'ga', git_add, opts('Git add'))
            vim.keymap.set('n', 'l', edit_or_open, opts('Edit or open'))
            vim.keymap.set('n', 'L', edit_and_close_tree_or_open, opts('Edit and close tree or open'))
            vim.keymap.set('n', 'h', api.tree.close, opts('Close'))
            vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse all'))

            -- preview
            -- vim.keymap.set('n', 'p', preview_node, opts('Preview or open'))
            -- vim.keymap.set('n', '<Esc>', preview.unwatch, opts('Close previe`w'))
        end

        return {
            on_attach = on_attach,
            actions = {
                open_file = {
                    resize_window = false, -- don't resize window when opening file
                },
            },
        }
    end,
    config = function(_, opts)
        require('nvim-tree').setup(opts)

        -- keys section doesn't work for this plugin
        vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', { desc = 'Open nvim-tree and focus' })
        vim.keymap.set('n', '<leader>E', function()
            require('nvim-tree.api').tree.toggle({ silent = true, focus = false })
        end, { desc = 'Open nvim-tree without focus' })

        -- Make :bd and :q behave as usual when tree is visible
        vim.api.nvim_create_autocmd({ 'BufEnter', 'QuitPre' }, {
            nested = false,
            callback = function(e)
                local tree = require('nvim-tree.api').tree

                -- Nothing to do if tree is not opened
                if not tree.is_visible() then
                    return
                end

                -- How many focusable windows do we have? (excluding e.g. incline status window)
                local winCount = 0
                for _, winId in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_get_config(winId).focusable then
                        winCount = winCount + 1
                    end
                end

                -- We want to quit and only one window besides tree is left
                if e.event == 'QuitPre' and winCount == 2 then
                    vim.api.nvim_cmd({ cmd = 'qall' }, {})
                end

                -- :bd was probably issued an only tree window is left
                -- Behave as if tree was closed (see `:h :bd`)
                if e.event == 'BufEnter' and winCount == 1 then
                    -- Required to avoid "Vim:E444: Cannot close last window"
                    vim.defer_fn(function()
                        -- close nvim-tree: will go to the last buffer used before closing
                        tree.toggle({ find_file = true, focus = true })
                        -- re-open nivm-tree
                        tree.toggle({ find_file = true, focus = false })
                        -- focus tree for startup
                        tree.focus()
                    end, 10)
                end
            end,
        })
    end,
}
