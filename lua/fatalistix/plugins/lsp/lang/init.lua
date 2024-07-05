local lspExternal = {}
local lspInternal = {}

local modulePrefix = 'fatalistix.plugins.lsp.lang.'

local configDir = vim.fn.stdpath('config')
local langFilePaths = vim.split(vim.fn.glob(configDir .. '/lua/fatalistix/plugins/lsp/lang/*'), '\n')

for _, filePath in ipairs(langFilePaths) do
    local ok, _ = filePath:find(".*init.lua")

    if ok then
        goto continue
    end

    local bok, backslashPos = filePath:find(".*/")

    if not bok then
        goto continue
    end

    local dok, dotLuaPos = filePath:find(".*.lua")

    if not dok then
        goto continue
    end

    local lspName = filePath:sub(backslashPos + 1, dotLuaPos - 4)

    lspInternal[lspName] = require(modulePrefix .. lspName)

    ::continue::
end

function lspExternal.setup()
    for _, lang in pairs(lspInternal) do
        lang.setup()
    end
end

return lspExternal
