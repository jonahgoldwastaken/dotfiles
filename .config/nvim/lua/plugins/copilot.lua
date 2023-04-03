return {
	{
		"zbirenbaum/copilot.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("copilot").setup {
				panel = { enabled = false },
				suggestion = { enabled = false },
			}
			require("copilot_cmp").setup()
		end,
	},

	{
		"jonahgoldwastaken/copilot-status.nvim",
		dependencies = { "copilot.lua" },
		config = true,
		event = { "BufReadPre", "BufNewFile" },
		module = true,
		opts = {
			icons = {
				idle = " ",
				error = " ",
				offline = " ",
				warning = " ",
				loading = " ",
			},
			debug = true,
		},
	},
}
