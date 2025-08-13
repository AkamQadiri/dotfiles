return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>gs", vim.cmd.Git, desc = "Git status" },
		{ "<leader>gc", ":Git commit<CR>", desc = "Git commit" },
		{ "<leader>gp", ":Git push<CR>", desc = "Git push" },
		{ "<leader>gl", ":Git pull<CR>", desc = "Git pull" },
		{ "<leader>gF", ":Git fetch<CR>", desc = "Git fetch" },
		{ "<leader>gb", ":Git blame<CR>", desc = "Git blame" },
		{ "<leader>gd", ":Gvdiffsplit<CR>", desc = "Git diff split" },
	},
}
