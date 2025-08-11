return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        keys = {
            { "gd",         vim.lsp.buf.definition,  desc = "Go to definition" },
            { "K",          vim.lsp.buf.hover,       desc = "Hover" },
            { "<leader>rn", vim.lsp.buf.rename,      desc = "Rename" },
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
            { "gr",         vim.lsp.buf.references,  desc = "References" },
            { "<leader>f",  vim.lsp.buf.format,      desc = "Format" },
        },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- Setup mason first
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "arduino_language_server",
                    "bashls",
                    "clangd",    -- C/C++
                    "omnisharp", -- C#
                    "cmake",
                    "cssls",     -- CSS/SCSS
                    "dockerls",
                    "groovyls",
                    "html",
                    "jdtls", -- Java
                    "ts_ls", -- JavaScript/TypeScript
                    "jsonls",
                    "kotlin_language_server",
                    "lua_ls",
                    "marksman", -- Markdown
                    "ruff",     -- Python
                    "sqlls",
                    "lemminx",  -- XML
                    "yamlls",
                },
            })

            -- LSP settings
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Configure each language server
            local servers = {
                arduino_language_server = {},
                bashls = {},
                clangd = {},
                omnisharp = {},
                cmake = {},
                cssls = {},
                dockerls = {},
                groovyls = {},
                html = {},
                jdtls = {},
                ts_ls = {},
                jsonls = {},
                kotlin_language_server = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                marksman = {},
                ruff = {},
                sqlls = {},
                lemminx = {},
                yamlls = {},
            }

            for server, config in pairs(servers) do
                config.capabilities = capabilities
                lspconfig[server].setup(config)
            end

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end,
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        event = { "InsertEnter" },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                },
            })
        end,
    },
}
