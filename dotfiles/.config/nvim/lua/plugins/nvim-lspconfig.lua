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
		local root_dir = vim.fn.getcwd()

		vim.lsp.config("*", {
			capabilities = capabilities,
			root_dir = root_dir,
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

		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						diagnosticMode = "workspace",
					},
				},
			},
		})
	end,
}
