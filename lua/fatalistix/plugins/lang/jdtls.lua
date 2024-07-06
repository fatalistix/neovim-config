-- Плагин для lsp для java
return {
    'mfussenegger/nvim-jdtls',
    dependencies = {
        'neovim/nvim-lspconfig',
    },
    config = function()
        local capabilities = require('fatalistix.plugins.lsp.util.capabilities')
        local on_attach = require('fatalistix.plugins.lsp.util.on-attach')

        local cfg = {
            flags = {
                debounce_text_changes = 150,
            },
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { '/usr/bin/jdtls' },
            root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
            settings = {
                java = {
                    format = {
                        settings = {
                            -- Use Google's formating for java
                            url = '~/.local/share/eclipse/eclipse-java-google-style.xml',
                            profile = 'GoogleStyle',
                        },
                    },
                    signatureHelp = {
                        enabled = true,
                    },
                    contentProvider = {
                        -- Use fernflower util for libraries' code decompiling
                        preferred = 'fernflower',
                    },
                    -- Set options for completion
                    completion = {
                        favoriteStaticMembers = {
                            'org.hamcrest.MatcherAssert.assertThat',
                            'org.hamcrest.Matchers.*',
                            'org.hamcrest.CoreMatchers.*',
                            'org.junit.jupiter.api.Assertions.*',
                            'java.util.Objects.requireNonNull',
                            'java.util.Objects.requireNonNullElse',
                            'org.mockito.Mockito.*',
                        },
                        filteredTypes = {
                            'com.sun.*',
                            'io.micrometer.shaded.*',
                            'java.awt.*',
                            'jdk.*',
                            'sun.*',
                        },
                    },
                    -- Set options for organizing imports
                    sources = {
                        organizeImports = {
                            starThreshold = 9999,
                            staticStarThreshold = 9999,
                        },
                    },
                    -- Code generation settings
                    codeGeneration = {
                        toString = {
                            template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                        },
                        hashCodeEquals = {
                            useJava7Objects = true,
                        },
                        useBlocks = true,
                    },
                },
            },
        }
        require('jdtls').start_or_attach(cfg)
    end,
    event = { 'CmdlineEnter' },
    ft = { 'java' },
}
