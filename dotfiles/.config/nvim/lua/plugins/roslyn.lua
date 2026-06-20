return {
	"seblyng/roslyn.nvim",
	ft = { "cs", "razor" },
	init = function()
		-- Roslyn attaches to Razor/Blazor files under the "razor" filetype.
		vim.filetype.add({
			extension = {
				razor = "razor",
				cshtml = "razor",
			},
		})
	end,
	opts = {
		-- Search parent directories for the .sln.
		broad_search = true,
	},
}
