return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.sql_formatter,
                null_ls.builtins.formatting.cmake_format,
                null_ls.builtins.formatting.dotnet_format,
                null_ls.builtins.formatting.clang_format.with({
                    filetypes = { "arduino" },
                }),
                null_ls.builtins.formatting.npm_groovy_lint,
                null_ls.builtins.diagnostics.eslint_d,
                null_ls.builtins.code_actions.eslint_d,
            },
        })
    end,
}
