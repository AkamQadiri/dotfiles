return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "Trouble" },
	keys = {
		{ "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle trouble diagnostics" },
		{ "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Toggle symbols" },
	},
	opts = {},
}
