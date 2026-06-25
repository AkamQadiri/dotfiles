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

		local icons = {
			modified = "⬤",
			readonly = "",
			newfile = "",
			unnamed = "",
		}

		--- Filename plus status symbols, space-separated so the icons never touch
		--- (lualine's built-in filename component joins them with no separator).
		local function filename()
			local full = vim.fn.expand("%")
			local name = vim.fn.fnamemodify(full, ":t")
			if name == "" then
				name = icons.unnamed
			else
				name = name:gsub("%%", "%%%%") -- escape statusline specials
			end

			-- Status symbols only apply to real, file-backed buffers; skip them for
			-- help, terminals, quickfix, and plugin scratch buffers.
			if vim.bo.buftype ~= "" then
				return name
			end

			local symbols = {}
			-- A new file is inherently unsaved, so show the new-file icon or the
			-- modified dot, not both.
			if full ~= "" and vim.uv.fs_stat(full) == nil then
				table.insert(symbols, icons.newfile)
			elseif vim.bo.modified then
				table.insert(symbols, icons.modified)
			end

			if not vim.bo.modifiable or vim.bo.readonly then
				table.insert(symbols, icons.readonly)
			end

			if #symbols == 0 then
				return name
			end
			return name .. " " .. table.concat(symbols, " ")
		end

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
