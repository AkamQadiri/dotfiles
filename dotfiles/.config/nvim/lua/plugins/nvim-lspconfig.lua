return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	keys = {
		{ "gd", vim.lsp.buf.definition, desc = "Jump to definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Jump to declaration" },
		{ "gr", vim.lsp.buf.references, desc = "Show all references in quickfix" },
		{ "gy", vim.lsp.buf.type_definition, desc = "Jump to type definition" },
		{ "gi", vim.lsp.buf.implementation, desc = "Jump to implementation" },
		{ "K", vim.lsp.buf.hover, desc = "Show hover documentation" },
		{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename symbol project-wide" },
		{ "<leader>ca", vim.lsp.buf.code_action, desc = "Show available code actions" },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
			jump = {
				on_jump = function(_, bufnr)
					vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
				end,
			},
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
}
