-- session manager for nvim
-- config stoled partly from astronvim
return {
    "stevearc/resession.nvim",
    lazy = true,
    opts = {},
    config = function(_, opts)
        local resession = require('resession')
        resession.setup(opts)
    end
}
