return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = "Telescope",
	keys = {
		{
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			desc = "Find files",
		},
		{
			"<leader>gf",
			"<cmd>Telescope git_files<cr>",
			desc = "Git files",
		},
		{
			"<leader>fw",
			function()
				local word = vim.fn.expand("<cword>")
				require("telescope.builtin").grep_string({
					search = word,
				})
			end,
			desc = "Grep current word",
		},
		{
			"<leader>fW",
			function()
				local word = vim.fn.expand("<cWORD>")
				require("telescope.builtin").grep_string({
					search = word,
				})
			end,
			desc = "Grep current WORD",
		},
		{
			"<leader>fs",
			function()
				require("telescope.builtin").grep_string({
					search = vim.fn.input("Grep > "),
				})
			end,
			desc = "Grep search",
		},
		{
			"<leader>fh",
			"<cmd>Telescope help_tags<cr>",
			desc = "Help tags",
		},
	},
}
