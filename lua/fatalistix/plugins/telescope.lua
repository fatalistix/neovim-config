-- telescope (обзор всего)
-- https://github.com/nvim-telescope/telescope.nvim
return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
    },
    keys = {
        {
            "<leader>,",
            "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
            desc = "Switch Buffer",
        },
        {
            "<leader>:",
            "<cmd>Telescope command_history<cr>",
            desc = "Command History",
        },
        -- find
        {
            "<leader>fb",
            "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
            desc = "Buffers",
        },
        {
            "<leader>fg",
            "<cmd>Telescope git_files<cr>",
            desc = "Find Files (git-files)",
        },
        {
            "<leader>fr",
            "<cmd>Telescope oldfiles<cr>",
            desc = "Recent",
        },
        -- git
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "commits" },
        { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "status" },
        --search
        { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
        { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        telescope.load_extension("fzf")
        telescope.load_extension("aerial")


        telescope.setup({
           defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
           },
           pickers = {
               buffers = {
                   sort_mru = true,
                   mappings = {
                       i = {
                           ["<C-d>"] = "delete_buffer",
                       }
                   }
               }
           },
           extensions = {
               aerial = {
                   -- Display symbols as <root>.<parent>.<symbol>
                   show_nesting = {
                       ["_"] = false, -- This key will be the default
                       json = true, -- You can set the option for specific filetypes
                       yaml = true,
                   }
               }
           }
        })


        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Fuzzy find files" })
        -- vim.keymap.set('n' , '<C-p>', builtin.git_files, { desc = "Fuzzy find git files" })

        -- vim.keymap.set('n', '<leader>fb', function()
        --     builtin.buffers({ sort_mru = true, ignore_current_buffer = true })
        -- end, { desc = "List opened buffers" })

        -- vim.keymap.set('n', '<leader>/', function()
        --     builtin.grep_string({ search = vim.fn.input('Grep > ') })
        -- end, { desc = "Grep string" })

        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "List help tags" })
        vim.keymap.set('n', '<leader>fx', builtin.treesitter, { desc = "List treesitter funcs, vars" })
    end
}
