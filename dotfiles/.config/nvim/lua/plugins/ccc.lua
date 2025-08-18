return {
	"uga-rosa/ccc.nvim",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>ucp", "<cmd>CccPick<cr>", desc = "Open color picker" },
		{ "<leader>ucc", "<cmd>CccConvert<cr>", desc = "Convert color format" },
		{ "<leader>uch", "<cmd>CccHighlighterToggle<cr>", desc = "Toggle color highlighting in buffer" },
	},
	opts = {
		highlighter = {
			auto_enable = true,
			lsp = true,
		},
	},
}
