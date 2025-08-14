return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	lazy = true,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup({
			expand_lines = false,
			layouts = {
				{
					position = "left",
					size = 0.2,
					elements = {
						{ id = "stacks", size = 0.2 },
						{ id = "scopes", size = 0.5 },
						{ id = "breakpoints", size = 0.15 },
						{ id = "watches", size = 0.15 },
					},
				},
				{
					position = "bottom",
					size = 0.2,
					elements = {
						{ id = "repl", size = 0.3 },
						{ id = "console", size = 0.7 },
					},
				},
			},
		})

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.fn.sign_define(
			"DapBreakpoint",
			{ text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
		)
		vim.fn.sign_define("DapBreakpointCondition", {
			text = "",
			texthl = "DapBreakpointCondition",
			linehl = "DapBreakpointCondition",
			numhl = "DapBreakpointCondition",
		})
		vim.fn.sign_define(
			"DapStopped",
			{ text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
		)
	end,
}
