return {
	"uga-rosa/ccc.nvim",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>cp", "<cmd>CccPick<cr>", desc = "Color picker" },
		{ "<leader>cc", "<cmd>CccConvert<cr>", desc = "Convert color" },
		{ "<leader>ch", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle color highlighter" },
	},
	opts = {
		highlighter = {
			auto_enable = true,
			lsp = true,
		},
	},
}
