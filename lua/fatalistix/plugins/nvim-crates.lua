-- cargo tools
-- https://github.com/Saecki/crates.nvim
return {
    'Saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    enabled = false,
    tag = 'stable',
    opts = {
        src = {
            cmp = { enabled = true },
        },
    },
}
