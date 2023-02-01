local icons = require "config.icons"

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			config = function(_, opts) require("dapui").setup(opts) end,
			opts = {
				icons = {
					expanded = icons.triangle.Down,
					collapsed = icons.triangle.Right,
					current_frame = icons.dap.StackframeActive,
				},
				controls = {
					icons = {
						pause = icons.dap.Pause,
						play = icons.dap.Play,
						step_into = icons.dap.StepInto,
						step_over = icons.dap.StepOver,
						step_out = icons.dap.StepOut,
						step_back = icons.dap.StepBack,
						run_last = icons.dap.Restart,
						terminate = icons.dap.Disconnect,
					},
				},
			},
		},

		{
			"jay-babu/mason-nvim-dap.nvim",
			config = function()
				require("mason-nvim-dap").setup { automatic_setup = true }
				require("mason-nvim-dap").setup_handlers()
			end,
		},
	},

	keys = {
		{
			"<leader>db",
			function() require("dap").toggle_breakpoint() end,
			desc = "Toggle Breakpoint",
		},

		{
			"<leader>dc",
			function() require("dap").continue() end,
			desc = "Continue",
		},

		{
			"<leader>do",
			function() require("dap").step_over() end,
			desc = "Step Over",
		},

		{
			"<leader>di",
			function() require("dap").step_into() end,
			desc = "Step Into",
		},

		{
			"<leader>dw",
			function() require("dap.ui.widgets").hover() end,
			desc = "Widgets",
		},

		{
			"<leader>dr",
			function() require("dap").repl.open() end,
			desc = "Repl",
		},

		{
			"<leader>du",
			function() require("dapui").toggle {} end,
			desc = "Dap UI",
		},
	},
	init = function()
		vim.fn.sign_define("DapBreakpoint", { text = icons.dap.Breakpoint })
		vim.fn.sign_define("DapBreakpointCondition", { text = icons.dap.ConditionBreakpoint })
		vim.fn.sign_define("DapLogPoint", { text = icons.dap.LogPoint })
		vim.fn.sign_define("DapStopped", { text = icons.dap.Stackframe })
		vim.fn.sign_define("DapBreakpointRejected", { text = icons.dap.RejectedBreakpoint })
	end,
	config = function()
		local dap = require "dap"
		local dapui = require "dapui"

		dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
		dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
		dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end
	end,
}
