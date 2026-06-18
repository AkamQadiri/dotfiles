return {
	"artemave/workspace-diagnostics.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("workspace-diagnostics", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				require("workspace-diagnostics").populate_workspace_diagnostics(client, event.buf)
			end,
		})
	end,
}
