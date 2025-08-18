return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "Trouble" },
	keys = {
		{ "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle diagnostics panel" },
		{ "<leader>ds", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Toggle document symbols panel" },
	},
	opts = {},
}
