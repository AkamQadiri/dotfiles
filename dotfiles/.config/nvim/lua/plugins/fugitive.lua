return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>gs", vim.cmd.Git, desc = "Open git status window" },
		{ "<leader>gc", ":Git commit<CR>", desc = "Create git commit" },
		{ "<leader>gps", ":Git push<CR>", desc = "Push commits to remote" },
		{ "<leader>gpl", ":Git pull<CR>", desc = "Pull commits from remote" },
		{ "<leader>gf", ":Git fetch<CR>", desc = "Fetch remote changes" },
		{ "<leader>gb", ":Git blame<CR>", desc = "Show line-by-line authorship" },
		{ "<leader>gd", ":Gvdiffsplit<CR>", desc = "Open git diff in split window" },
		{ "<leader>gl", ":Git log<CR>", desc = "Show git commit history" },
	},
}
