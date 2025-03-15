return {
	-- Auto-completion
	{
		"saghen/blink.cmp",
		dependencies = {
			"moyiz/blink-emoji.nvim",
			{
				"saghen/blink.compat",
				version = "*",
				opts = {},
			},
		},
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },
			sources = {
				default = {
					"lsp",
					"path",
					"buffer",
					"emoji",
					"obsidian",
					"obsidian_new",
					"obsidian_tags",
				},
				providers = {
					obsidian = {
						name = "obsidian",
						module = "blink.compat.source",
					},
					obsidian_new = {
						name = "obsidian_new",
						module = "blink.compat.source",
					},
					obsidian_tags = {
						name = "obsidian_tags",
						module = "blink.compat.source",
					},
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15, -- Tune by preference
						opts = { insert = true }, -- Insert emoji (default) or complete its name
						should_show_items = function()
							return vim.tbl_contains(
								-- Enable emoji completion only for git commits and markdown.
								-- By default, enabled for all file-types.
								{ "gitcommit", "markdown" },
								vim.o.filetype
							)
						end,
					},
				},
			},
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			completion = {
				trigger = {
					show_on_insert_on_trigger_character = true,
					show_on_keyword = true,
				},
				ghost_text = {
					enabled = true,
				},
				menu = {
					draw = {
						align_to = "label",
						columns = { { "kind" }, { "label", "label_description", gap = 1 } },
						components = {
							kind = {
								ellipsis = false,
								width = { fill = true },
								text = function(ctx) return "[" .. ctx.kind:upper() .. "]" end,
								highlight = function(ctx) return ctx.kind_hl end,
							},
						},
					},
				},
			},
		},
	},

	-- Surrounding
	{
		"echasnovski/mini.surround",
		keys = { "s" },
		main = "mini.surround",
		opts = {
			n_lines = 500,
		},
	},

	-- Better comments
	{
		"echasnovski/mini.comment",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.comment",
		config = true,
	},

	-- Better line split/joins
	{
		"echasnovski/mini.splitjoin",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.splitjoin",
		config = true,
	},

	-- Code operations
	{
		"echasnovski/mini.operators",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.operators",
		config = true,
	},
}
