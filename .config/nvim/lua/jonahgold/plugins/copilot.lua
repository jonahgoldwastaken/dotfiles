return {
	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		event = { "BufReadPost" },
		config = function()
			require("copilot").setup {
				panel = { enabled = false },
				suggestion = { enabled = false },
			}
			require("copilot_cmp").setup()
		end,
	},

	-- Copilot status
	{
		"jonahgoldwastaken/copilot-status.nvim",
		dependencies = { "copilot.lua" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			debug = true,
		},
	},
}
