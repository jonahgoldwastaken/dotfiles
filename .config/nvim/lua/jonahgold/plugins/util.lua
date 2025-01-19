return {
	-- Plenary
	{ "nvim-lua/plenary.nvim", lazy = false, priority = 10000 },

	-- Session storage
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		config = true,
		keys = {
			{ "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
			{
				"<leader>ql",
				function() require("persistence").load { last = true } end,
				desc = "Restore Last Session",
			},
			{
				"<leader>qd",
				function() require("persistence").stop() end,
				desc = "Don't Save Current Session",
			},
		},
	},

	-- Icons
	{
		"nvim-tree/nvim-web-devicons",
		opts = function()
			return {
				default = false,
				color_icons = false,
				override = {
					default_icon = {
						icon = require("jonahgold.util.icons").documents.File,
						name = "Default",
					},
				},
			}
		end,
	},
}
