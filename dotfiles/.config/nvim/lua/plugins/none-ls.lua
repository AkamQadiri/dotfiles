return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "williamboman/mason.nvim",
        "jay-babu/mason-null-ls.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local null_ls = require("null-ls")

        -- Setup mason-null-ls first
        require("mason-null-ls").setup({
            ensure_installed = {
                "prettier",
                "shfmt",
                "sql-formatter",
                "cmake-format",
                "dotnet-format",
                "ruff",
                "eslint_d",
                "npm-groovy-lint",
            },
            automatic_installation = true,
        })

        -- Setup none-ls
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.sql_formatter,
                null_ls.builtins.formatting.cmake_format,
                null_ls.builtins.formatting.dotnet_format,
                null_ls.builtins.formatting.ruff,
                null_ls.builtins.diagnostics.ruff,
                null_ls.builtins.formatting.npm_groovy_lint,
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.code_actions.eslint_d,
            },
        })
    end,
}
