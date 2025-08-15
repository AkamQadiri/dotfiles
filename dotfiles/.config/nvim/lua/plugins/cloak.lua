return {
	"laytan/cloak.nvim",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>ct", "<cmd>CloakToggle<cr>", desc = "Toggle cloak" },
	},
	config = function()
		require("cloak").setup({
			enabled = true,
			cloak_character = "*",
			highlight_group = "Comment",
			patterns = {
				{
					-- .NET/C# configuration files
					file_pattern = {
						"appsettings*.json",
						"secrets.json",
						"launchSettings.json",
					},
					-- JSON key-value patterns for connection strings, keys, passwords
					cloak_pattern = {
						":.+", -- Cloak everything after colon in JSON
						"=.+", -- Also handle any = signs
					},
				},
				{
					-- Environment files
					file_pattern = {
						".env*",
						"*.env",
					},
					cloak_pattern = "=.+",
				},
				{
					-- JavaScript/TypeScript configs
					file_pattern = {
						"config.json",
						"settings.json",
						".npmrc",
						"wrangler.toml",
						".dev.vars",
					},
					cloak_pattern = {
						":.+", -- JSON values
						"=.+", -- TOML/env style
					},
				},
				{
					-- Python configs
					file_pattern = {
						"pyproject.toml",
						"setup.cfg",
						"*.ini",
						"*.cfg",
					},
					cloak_pattern = {
						"=.+",
						":.+",
					},
				},
				{
					-- Docker/YAML
					file_pattern = {
						"docker-compose*.yml",
						"docker-compose*.yaml",
						"*secrets*.yml",
						"*secrets*.yaml",
					},
					cloak_pattern = {
						":.+", -- YAML values
					},
				},
			},
		})
	end,
}

