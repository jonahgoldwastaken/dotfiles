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
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		lazy = false,
		init = function(plugin)
			require("lazy.core.loader").add_to_rtp(plugin)
			require "nvim-treesitter.query_predicates"
		end,
		opts = {
			sync_install = false,
			auto_install = true,
			ensure_installed = {
				"astro",
				"bash",
				"c",
				"css",
				"fish",
				"go",
				"gomod",
				"git_config",
				"gitcommit",
				"gitignore",
				"html",
				"javascript",
				"json",
				"json5",
				"jsonc",
				"kdl",
				"lua",
				"markdown",
				"markdown_inline",
				"php",
				"rust",
				"scss",
				"svelte",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"vue",
				"yaml",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
		},
		config = function(opts) require("nvim-treesitter.configs").setup(opts) end,
	},
}
