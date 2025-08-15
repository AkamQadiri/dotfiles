return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
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
		require("mason-nvim-dap").setup({
			ensure_installed = {
				"bash",
				"codelldb",
				"coreclr",
				"js",
				"python",
			},
			handlers = {},
		})
		require("mason-tool-installer").setup({
			ensure_installed = {
				-- Formatters
				"black",
				"clang-format",
				"prettier",
				"shfmt",
				"stylua",

				-- Linters
				"pylint",
				"shellcheck",
			},
		})
	end,
}
