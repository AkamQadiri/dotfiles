return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry", -- roslyn server
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"arduino_language_server",
				"autotools_ls",
				"bashls",
				"clangd",
				"cssls",
				"dockerls",
				"jsonls",
				"lemminx",
				"lua_ls",
				"marksman",
				"pyright",
				"superhtml",
				"taplo",
				"vtsls",
				"yamlls",
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
				"prettier",
				"ruff",
				"shfmt",
				"stylua",

				-- Linters
				"checkmake",
				"hadolint",
				"markdownlint-cli2",
				"shellcheck", -- used by bashls
				"sqlfluff",
				"yamllint",

				-- C# server (needs .NET SDK)
				"roslyn",
			},
		})
	end,
}
