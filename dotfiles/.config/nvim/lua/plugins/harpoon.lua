return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<leader>ma",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add current file to marks",
		},
		{
			"<leader>ml",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Show marks list",
		},
		{
			"<leader>m1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Jump to mark 1",
		},
		{
			"<leader>m2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Jump to mark 2",
		},
		{
			"<leader>m3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Jump to mark 3",
		},
		{
			"<leader>m4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Jump to mark 4",
		},
	},
}
