return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Telescope",
	keys = {
		{
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			desc = "Search files by name",
		},
		{
			"<leader>fg",
			"<cmd>Telescope git_files<cr>",
			desc = "Search git-tracked files",
		},
		{
			"<leader>fw",
			function()
				local word = vim.fn.expand("<cword>")
				require("telescope.builtin").grep_string({ search = word })
			end,
			desc = "Search cursor word in project",
		},
		{
			"<leader>fW",
			function()
				local word = vim.fn.expand("<cWORD>")
				require("telescope.builtin").grep_string({ search = word })
			end,
			desc = "Search cursor WORD in project",
		},
		{
			"<leader>fs",
			function()
				require("telescope.builtin").grep_string({
					search = vim.fn.input("Grep > "),
				})
			end,
			desc = "Search text in project files",
		},
		{
			"<leader>fh",
			"<cmd>Telescope help_tags<cr>",
			desc = "Search help documentation",
		},
	},
}
