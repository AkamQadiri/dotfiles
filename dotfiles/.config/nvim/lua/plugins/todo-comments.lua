return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>tT", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
		{ "<leader>tf", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
	},
	opts = {
		keywords = {
			FIX = { icon = "" },
			TODO = { icon = "" },
			HACK = { icon = "" },
			WARN = { icon = "" },
			PERF = { icon = "" },
			NOTE = { icon = "" },
			TEST = { icon = "" },
		},
	},
}
