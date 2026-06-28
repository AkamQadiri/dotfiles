--- Lock files and minified/build output carry a formatter-backed filetype
--- (json, yaml, css, js) but are machine-generated and must never be reflowed.
--- Patterns mirror the exclude globs in git/hooks/prepare-commit-msg.
local ignore_patterns = {
	"%-lock%.json$", -- package-lock.json (npm)
	"%.lock%.json$", -- packages.lock.json (nuget)
	"%-lock%.yaml$", -- pnpm-lock.yaml
	"%.lock$", -- yarn, cargo, poetry, composer, gem, ...
	"go%.sum$",
	"%.min%.js$",
	"%.min%.css$",
	"%.map$", -- source maps / build output
}

local function should_ignore(path)
	for _, pat in ipairs(ignore_patterns) do
		if path:match(pat) then
			return true
		end
	end
	return false
end

--- Format every project file that has a configured formatter.
--- Scope: git-tracked plus untracked-but-not-ignored files, falling back to a
--- recursive scan of the cwd outside a git repo. Only filetypes listed in
--- `formatters_by_ft` are touched, and LSP formatting is skipped so this never
--- depends on a language server being attached to a background buffer.
local function format_project()
	local conform = require("conform")

	local files = vim.fn.systemlist({ "git", "ls-files", "--cached", "--others", "--exclude-standard" })
	if vim.v.shell_error ~= 0 then
		files = vim.fn.globpath(vim.fn.getcwd(), "**/*", false, true)
	end

	local current = vim.api.nvim_get_current_buf()
	local checked, formatted, failed = 0, 0, 0
	local saved_eventignore = vim.o.eventignore
	vim.o.eventignore = "all" -- batch-load buffers without firing LSP/lint/format-on-save

	local ok, err = pcall(function()
		for _, path in ipairs(files) do
			local ft = vim.filetype.match({ filename = path })
			if ft and conform.formatters_by_ft[ft] and not should_ignore(path) and vim.fn.filereadable(path) == 1 then
				checked = checked + 1
				local bufnr = vim.fn.bufadd(path)
				local was_loaded = vim.api.nvim_buf_is_loaded(bufnr)

				-- Isolate each file so one failure (e.g. unwritable) skips it, not the run.
				local done = pcall(function()
					vim.fn.bufload(bufnr)
					vim.bo[bufnr].filetype = ft -- set manually; FileType is suppressed above
					conform.format({ bufnr = bufnr, lsp_format = "never", timeout_ms = 5000 })
					if vim.bo[bufnr].modified then
						vim.api.nvim_buf_call(bufnr, function()
							vim.cmd("silent keepjumps update")
						end)
						formatted = formatted + 1
					end
				end)
				if not done then
					failed = failed + 1
				end

				if not was_loaded and bufnr ~= current then
					-- drop buffers we opened; force discards changes left by a failed write
					vim.api.nvim_buf_delete(bufnr, { force = true })
				end
			end
		end
	end)

	vim.o.eventignore = saved_eventignore

	if not ok then
		vim.notify("Project format failed: " .. tostring(err), vim.log.levels.ERROR)
		return
	end
	local msg = ("Formatted %d of %d file(s)"):format(formatted, checked)
	if failed > 0 then
		msg = msg .. (", %d failed"):format(failed)
	end
	vim.notify(msg, failed > 0 and vim.log.levels.WARN or vim.log.levels.INFO)
end

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "FormatProject" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "v" },
			desc = "Format current buffer",
		},
		{
			"<leader>cF",
			format_project,
			mode = "n",
			desc = "Format whole project",
		},
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				-- Prettier-supported
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				yaml = { "prettier" },

				html = { "superhtml" }, -- not prettier (self-closes void tags)

				-- Language-specific
				markdown = { "markdownlint-cli2" },
				python = { "ruff_organize_imports", "ruff_format" },
				lua = { "stylua" },
				bash = { "shfmt" },
				sh = { "shfmt" },
				toml = { "taplo" },
				sql = { "sqlfluff" }, -- needs a dialect in .sqlfluff
			},
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = function(bufnr)
				-- Skip the same lock/minified files the project formatter ignores,
				-- so saving e.g. package-lock.json never reflows it.
				if should_ignore(vim.api.nvim_buf_get_name(bufnr)) then
					return
				end
				return { timeout_ms = 500 }
			end,
		})

		vim.api.nvim_create_user_command("FormatProject", format_project, {
			desc = "Format every project file with conform",
		})
	end,
}
