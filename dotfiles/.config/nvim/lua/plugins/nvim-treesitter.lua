return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		local attempted = {} -- langs already tried this session

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter-auto", { clear = true }),
			callback = function(args)
				local buf = args.buf
				local lang = vim.treesitter.language.get_lang(args.match) or args.match

				local function enable()
					-- No-op for filetypes without a parser/queries.
					if not pcall(vim.treesitter.start, buf, lang) then
						return
					end
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end

				if vim.tbl_contains(require("nvim-treesitter.config").get_installed(), lang) then
					enable()
				elseif not attempted[lang] then
					attempted[lang] = true
					-- Install on first encounter, then enable once built.
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
