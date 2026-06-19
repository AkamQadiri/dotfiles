return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		local tsconfig = require("nvim-treesitter.config")
		local attempted = {} -- langs already tried this session

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter-auto", { clear = true }),
			callback = function(args)
				local buf = args.buf

				-- Files only: skips Telescope previews/prompts, the Lazy UI,
				-- help, terminals, quickfix, etc.
				if vim.bo[buf].buftype ~= "" then
					return
				end

				local lang = vim.treesitter.language.get_lang(args.match) or args.match

				local function enable()
					-- No-op for filetypes without a parser/queries.
					if not pcall(vim.treesitter.start, buf, lang) then
						return
					end
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end

				if vim.tbl_contains(tsconfig.get_installed(), lang) then
					enable()
				elseif not attempted[lang] and vim.tbl_contains(tsconfig.get_available(), lang) then
					attempted[lang] = true
					-- Install on first encounter (blocking), then enable.
					local ok, task = pcall(ts.install, { lang }, { summary = false })
					if ok and task then
						task:wait(120000)
						if vim.api.nvim_buf_is_valid(buf) then
							enable()
						end
					end
				end
			end,
		})
	end,
}
