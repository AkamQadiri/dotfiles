return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- bash, c, cpp lint via their LSPs
		require("lint").linters_by_ft = {
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			python = { "ruff" },
			yaml = { "yamllint" },
			markdown = { "markdownlint-cli2" },
			dockerfile = { "hadolint" },
			sql = { "sqlfluff" }, -- needs a dialect in .sqlfluff
			make = { "checkmake" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				require("lint").try_lint(nil, { ignore_errors = true })
			end,
		})
	end,
}
