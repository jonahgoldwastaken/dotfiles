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
		opts =
				function()
					if vim.env.TERM ~= "alacritty" then
						return {
							icons = {
								idle = " ",
								error = " ",
								offline = " ",
								warning = " ",
								loading = " ",
							},
							debug = true,
						}
					end

					return {
						debug = true,
					}
				end,
	},
}
