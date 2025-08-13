return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"arduino_language_server",
				"bashls",
				"clangd",
				"omnisharp",
				"cssls",
				"html",
				"ts_ls",
				"jsonls",
				"lua_ls",
				"marksman",
				"pyright",
			},
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters
				"prettier",
				"stylua",
				"black",
				"clang-format",
				"shfmt",

				-- Linters
				"shellcheck",
				"pylint",
			},
		})
	end,
}
