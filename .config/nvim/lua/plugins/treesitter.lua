return {
	-- More and better text-object navigation
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		main = "mini.ai",
		opts = {
			n_lines = 500,
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			sync_install = false,
			auto_install = true,
			ensure_installed = {
				"bash",
				"scss",
				"css",
				"lua",
				"rust",
				"astro",
				"svelte",
				"vue",
				"javascript",
				"typescript",
				"json5",
				"json",
				"jsonc",
				"toml",
				"gomod",
				"go",
				"rust",
				"markdown",
				"markdown_inline",
				"vim",
				"yaml",
				"vimdoc",
				"fish",
				"tsx",
				"kdl",
				"fish",
			},
			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
		},
	},
}
