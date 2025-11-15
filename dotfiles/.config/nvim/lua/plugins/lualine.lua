return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		local clients_lsp = function()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if next(clients) == nil then
				return ""
			end

			local c = {}
			for _, client in pairs(clients) do
				table.insert(c, client.name)
			end
			return " " .. table.concat(c, "|")
		end

		local filename = {
			"filename",
			newfile_status = true,
			symbols = {
				modified = "⬤",
				readonly = "",
				unnamed = "",
				newfile = "",
			},
		}

		require("lualine").setup({
			options = {
				theme = "dracula",
				component_separators = "",
				section_separators = "",
			},
			sections = {
				lualine_a = {
					{ "mode" },
				},
				lualine_b = {
					{
						"filetype",
						icon_only = true,
						padding = { left = 1, right = 0 },
					},
					filename,
				},
				lualine_c = {
					{
						"branch",
						icon = "",
					},
					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						colored = false,
					},
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						update_in_insert = true,
					},
				},
				lualine_y = { clients_lsp },
				lualine_z = {
					{ "location", icon = "" },
				},
			},
			inactive_sections = {
				lualine_a = { filename },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			extensions = { "trouble" },
		})
	end,
}
