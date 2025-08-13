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

		-- Set up keymaps manually for better control
		local api = require("Comment.api")

		-- Normal mode
		vim.keymap.set("n", "<leader>cc", api.toggle.linewise.current, { desc = "Toggle comment line" })
		vim.keymap.set("n", "<leader>cb", api.toggle.blockwise.current, { desc = "Toggle comment block" })

		-- Visual mode
		vim.keymap.set("v", "<leader>cc", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
			api.toggle.linewise(vim.fn.visualmode())
		end, { desc = "Toggle comment line" })

		vim.keymap.set("v", "<leader>cb", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
			api.toggle.blockwise(vim.fn.visualmode())
		end, { desc = "Toggle comment block" })
	end,
}

