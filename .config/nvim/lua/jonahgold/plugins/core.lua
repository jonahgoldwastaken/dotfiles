return {
	-- Plugin manager
	{ "folke/lazy.nvim", version = false },

	-- Colorscheme
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		lazy = false,
		init = function() vim.o.background = vim.env.os_theme or "dark" end,
		opts = { contrast = "hard" },
		config = function(_, opts)
			require("gruvbox").setup(opts)

			vim.cmd "colorscheme gruvbox"
		end,
	},
}
