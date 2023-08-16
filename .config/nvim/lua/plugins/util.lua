return {
    -- Plenary/util functions
    "nvim-lua/plenary.nvim",

    -- Nice UI
    "MunifTanjim/nui.nvim",

    -- Session storage
    {
        "folke/persistence.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
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
		config = function()
			require("nvim-web-devicons").setup {
				default = false,
				color_icons = false,
				override = {
					default_icon = {
						icon = require "util.icons".documents.File,
						name = "Default",
					},
				},
			}
		end,
	},
}
