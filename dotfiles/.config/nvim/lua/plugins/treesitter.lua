return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"arduino",
			"bash",
			"c",
			"cpp",
			"c_sharp",
			"css",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"scss",
			"typescript",
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	},
}
