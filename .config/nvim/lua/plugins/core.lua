return {
	-- Plugin manager
	{ "folke/lazy.nvim", version = false },

	-- Colorscheme
	{
		"projekt0n/github-nvim-theme",
		lazy = false,
		priority = 1000,
		main = "github-theme",
		init = function() vim.o.background = vim.env.os_theme or "dark" end,
		opts = {
			darken = {
				floats = true,
			},
		},
		config = function(_, opts)
			require("github-theme").setup(opts)

			if vim.o.background == "dark" then
				vim.cmd "colorscheme github_dark_high_contrast"
			else
				vim.cmd "colorscheme github_light_high_contrast"
			end
		end,
	},
}
