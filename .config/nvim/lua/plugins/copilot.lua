return {
    -- Copilot
	{
		"zbirenbaum/copilot.lua",
		event = { "BufReadPost" },
		cond = function()
			local path = vim.loop.cwd()
			return path ~= nil and path:find "work" == nil
		end,
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
		cond = function()
			local path = vim.loop.cwd()
			return path ~= nil and path:find "work" == nil
		end,
		opts = {
            debug = true,
        }
	},
}
