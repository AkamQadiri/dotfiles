return {
	"neovim/nvim-lspconfig",
	dependencies = { "hrsh7th/cmp-nvim-lsp" },
	keys = {
		{ "gd", vim.lsp.buf.definition, desc = "Jump to definition" },
		{ "gD", vim.lsp.buf.declaration, desc = "Jump to declaration" },
		{ "gr", vim.lsp.buf.references, desc = "Show all references in quickfix" },
		{ "gtd", vim.lsp.buf.type_definition, desc = "Jump to type definition" },
		{ "gi", vim.lsp.buf.implementation, desc = "Jump to implementation" },
		{ "K", vim.lsp.buf.hover, desc = "Show hover documentation" },
		{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename symbol project-wide" },
		{ "<leader>ca", vim.lsp.buf.code_action, desc = "Show available code actions" },
		{ "<leader>cf", vim.lsp.buf.format, desc = "Format current buffer" },
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- Set rounded borders for all LSP floating windows
		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local function get_root_dir(bufnr, on_dir)
			local util = require("lspconfig.util")
			local fname = vim.api.nvim_buf_get_name(bufnr)

			-- Version control markers
			local vcs_root = util.find_git_ancestor(fname) or util.root_pattern(".svn", ".hg")(fname)

			if vcs_root then
				return on_dir(vcs_root)
			end

			-- Common project markers
			local project_root = util.root_pattern(
				-- Build files
				"Makefile",
				"makefile",
				"CMakeLists.txt",
				"build.gradle",
				"pom.xml",

				-- Language-specific project files
				"package.json", -- JS/TS
				"tsconfig.json", -- TypeScript
				"jsconfig.json", -- JavaScript
				".eslintrc.json", -- JS/TS
				"pyproject.toml", -- Python
				"setup.py", -- Python
				"setup.cfg", -- Python
				"requirements.txt", -- Python
				"Pipfile", -- Python
				"*.sln", -- C#/.NET
				"*.csproj", -- C#/.NET
				"project.json", -- C#/.NET
				"platformio.ini", -- Arduino
				"arduino.json", -- Arduino
				".clang-format", -- C/C++
				".clang-tidy", -- C/C++
				"compile_commands.json", -- C/C++
				"Cargo.toml", -- Rust
				"go.mod", -- Go

				-- Config files
				".luarc.json", -- Lua
				".luarc.jsonc", -- Lua
				".stylua.toml", -- Lua

				-- Web projects
				"index.html", -- HTML projects
				"tailwind.config.js", -- CSS/Tailwind
				"postcss.config.js", -- CSS

				-- Documentation
				"README.md",
				"readme.md"
			)(fname)

			if project_root then
				return on_dir(project_root)
			end

			-- Fall back to the file's directory
			local fallback = vim.fn.fnamemodify(fname, ":h")

			if fallback == vim.env.HOME then
				-- This tells LSP to only analyze this specific file
				return on_dir(vim.fn.fnamemodify(fname, ":p"))
			end

			on_dir(fallback)
		end

		vim.lsp.config("*", {
			capabilities = capabilities,
			root_dir = get_root_dir,
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						diagnosticMode = "workspace",
					},
				},
			},
		})
	end,
}
