-- cargo tools
-- https://github.com/Saecki/crates.nvim
return {
    'Saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    tag = 'stable',
    opts = {
        src = {
            cmp = { enabled = true },
        },
    },
}
