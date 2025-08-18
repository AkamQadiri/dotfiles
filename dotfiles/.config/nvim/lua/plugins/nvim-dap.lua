return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = {
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "Start/continue debugging",
		},
		{
			"<S-F5>",
			function()
				require("dap").terminate()
			end,
			desc = "Stop debugging session",
		},
		{
			"<C-S-F5>",
			function()
				require("dap").restart()
			end,
			desc = "Restart debugging session",
		},
		{
			"<F9>",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle breakpoint on current line",
		},
		{
			"<S-F9>",
			function()
				require("dapui").eval()
			end,
			desc = "Evaluate expression under cursor",
			mode = { "n", "v" },
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "Step over current line",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "Step into function",
		},
		{
			"<S-F11>",
			function()
				require("dap").step_out()
			end,
			desc = "Step out of current function",
		},
		{
			"<F12>",
			function()
				require("dapui").toggle()
			end,
			desc = "Toggle debug UI panels",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("nvim-dap-virtual-text").setup()
		require("dapui").setup()

		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticInfo" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticWarn" })
		vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
		vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticHint" })

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
