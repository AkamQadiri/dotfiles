return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>dt", "<cmd>Trouble todo toggle<cr>", desc = "Toggle TODO list panel" },
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Search TODO comments in project" },
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
