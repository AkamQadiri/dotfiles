return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	keys = {
		{ "gd", vim.lsp.buf.definition, desc = "Jump to definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Jump to declaration" },
		{ "gr", vim.lsp.buf.references, desc = "Show all references in quickfix" },
		{ "gtd", vim.lsp.buf.type_definition, desc = "Jump to type definition" },
		{ "gi", vim.lsp.buf.implementation, desc = "Jump to implementation" },
		{ "K", vim.lsp.buf.hover, desc = "Show hover documentation" },
		{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename symbol project-wide" },
		{ "<leader>ca", vim.lsp.buf.code_action, desc = "Show available code actions" },
		{ "<leader>cf", vim.lsp.buf.format, desc = "Format current buffer" },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Set rounded borders for all LSP floating windows
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
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
