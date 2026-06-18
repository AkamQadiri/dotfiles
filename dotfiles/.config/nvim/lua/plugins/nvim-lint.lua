return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("lint").linters_by_ft = {
			bash = { "shellcheck" },
			sh = { "shellcheck" },
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			python = { "pylint" },
			c = { "clangtidy" },
			cpp = { "clangtidy" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				require("lint").try_lint(nil, { ignore_errors = true })
			end,
		})
	end,
}
