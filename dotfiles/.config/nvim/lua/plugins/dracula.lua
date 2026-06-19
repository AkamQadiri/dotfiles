return {
	"Mofiqul/dracula.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("dracula").setup({
			transparent_bg = true,
		})

		vim.cmd.colorscheme("dracula")
		local nf = vim.api.nvim_get_hl(0, { name = "NormalFloat", link = false })
		local fb = vim.api.nvim_get_hl(0, { name = "FloatBorder", link = false })
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = fb.fg, bg = nf.bg })
	end,
}
