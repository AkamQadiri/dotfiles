return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- JS/TS family - prettier → eslint → LSP
				javascript = { "prettier-eslint", "prettier", "eslint", stop_after_first = true },
				javascriptreact = { "prettier-eslint", "prettier", "eslint", stop_after_first = true },
				typescript = { "prettier-eslint", "prettier", "eslint", stop_after_first = true },
				typescriptreact = { "prettier-eslint", "prettier", "eslint", stop_after_first = true },

				-- Prettier-supported - prettier → LSP
				json = { "prettier", stop_after_first = true },
				jsonc = { "prettier", stop_after_first = true },
				css = { "prettier", stop_after_first = true },
				scss = { "prettier", stop_after_first = true },
				html = { "prettier", stop_after_first = true },
				markdown = { "prettier", stop_after_first = true },
				yaml = { "prettier", stop_after_first = true },

				-- Language-specific - formatter → LSP
				c = { "clang-format", stop_after_first = true },
				cpp = { "clang-format", stop_after_first = true },
				arduino = { "clang-format", stop_after_first = true },
				python = { "black", stop_after_first = true },
				lua = { "stylua", stop_after_first = true },
				bash = { "shfmt", stop_after_first = true },
				sh = { "shfmt", stop_after_first = true },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})
	end,
}

