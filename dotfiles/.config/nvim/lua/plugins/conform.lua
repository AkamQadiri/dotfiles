return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "v" },
			desc = "Format current buffer",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- Prettier-supported
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				yaml = { "prettier" },

				html = { "superhtml" }, -- not prettier (self-closes void tags)

				-- Language-specific
				markdown = { "markdownlint-cli2" },
				python = { "ruff_organize_imports", "ruff_format" },
				lua = { "stylua" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				toml = { "taplo" },
				sql = { "sqlfluff" }, -- needs a dialect in .sqlfluff
			},
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = {
				timeout_ms = 500,
			},
		})
	end,
}
