return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    build = ':TSUpdate',
    opts = {
        ensure_installed = {"arduino", "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css", "dockerfile",
                            "editorconfig", "groovy", "html", "java", "javadoc", "javascript", "jq", "jsdoc", "json",
                            "kotlin", "lua", "luadoc", "luap", "make", "markdown", "markdown_inline", "python", "scss",
                            "sql", "typescript", "vimdoc", "xml", "yaml"},
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true
        },
        indent = {
            enable = true
        }
    }
}
