local util = require "util"

return {
	-- Copilot
	{
		"zbirenbaum/copilot.lua",
		event = { "BufReadPost" },
		cond = function() return util.in_work_dir() == false end,
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
		cond = function() return util.in_work_dir() == false end,
		opts = {
			debug = true,
		},
	},
}
