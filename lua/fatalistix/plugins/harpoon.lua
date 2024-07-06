-- harpoon - buffers marker
-- https://github.com/ThePrimeagen/harpoon
return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local harpoon = require('harpoon')
        harpoon:setup({})

        -- basic telescope configuration
        local conf = require('telescope.config').values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require('telescope.pickers')
                .new(require('telescope.themes').get_dropdown({}), {
                    prompt_title = 'Harpoon',
                    finder = require('telescope.finders').new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end

        vim.keymap.set('n', '<leader>ha', function()
            harpoon:list():add()
        end, { desc = 'Harpoon mark buffer' })
        vim.keymap.set('n', '<leader>hu', function()
            toggle_telescope(harpoon:list())
        end, { desc = 'Harpoon marks (ui)' })

        vim.keymap.set('n', '<leader>h1', function()
            harpoon:list():select(1)
        end, { desc = 'Harpoon 1' })
        vim.keymap.set('n', '<leader>h2', function()
            harpoon:list():select(2)
        end, { desc = 'Harpoon 2' })
        vim.keymap.set('n', '<leader>h3', function()
            harpoon:list():select(3)
        end, { desc = 'Harpoon 3' })
        vim.keymap.set('n', '<leader>h4', function()
            harpoon:list():select(4)
        end, { desc = 'Harpoon 4' })

        -- переключить предыдущий и слудеющий буфферы в пределах списка Harpoon
        vim.keymap.set('n', '[h', function()
            harpoon:list():prev()
        end, { desc = 'Harpoon prev mark' })
        vim.keymap.set('n', ']h', function()
            harpoon:list():next()
        end, { desc = 'Harpoon next mark' })
        vim.keymap.set('n', '<leader>h[', function()
            harpoon:list():prev()
        end, { desc = 'Harpoon prev mark' })
        vim.keymap.set('n', '<leader>h]', function()
            harpoon:list():next()
        end, { desc = 'Harpoon next mark' })

        harpoon:extend({
            UI_CREATE = function(cx)
                vim.keymap.set('n', '<C-v>', function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr, desc = 'Harpoon open mark vsplit' })

                vim.keymap.set('n', '<C-s>', function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr, desc = 'Harpoon open mark in split' })

                vim.keymap.set('n', '<C-t>', function()
                    harpoon.ui:select_menu_item({ tabedit = true })
                end, { buffer = cx.bufnr, desc = 'Harpoon open mark in new tab' })
            end,
        })
    end,
}
