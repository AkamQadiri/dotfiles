return {
	"numToStr/comment.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("Comment").setup({
			mappings = {
				basic = false,
				extra = false,
			},
		})

		local api = require("Comment.api")

		vim.keymap.set("n", "gcc", api.toggle.linewise.current, { desc = "Toggle line comment" })
		vim.keymap.set("n", "gbc", api.toggle.blockwise.current, { desc = "Toggle block comment" })

		vim.keymap.set("v", "gc", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
			api.toggle.linewise(vim.fn.visualmode())
		end, { desc = "Toggle line comments" })

		vim.keymap.set("v", "gb", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
			api.toggle.blockwise(vim.fn.visualmode())
		end, { desc = "Toggle block comments" })
	end,
}
