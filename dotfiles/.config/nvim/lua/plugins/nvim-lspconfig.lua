return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	keys = {
		{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
		{ "K", vim.lsp.buf.hover, desc = "Hover" },
		{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename" },
		{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
		{ "gr", vim.lsp.buf.references, desc = "References" },
		{ "<leader>f", vim.lsp.buf.format, desc = "Format" },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
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
