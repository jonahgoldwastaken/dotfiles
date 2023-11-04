local icons = require "util.icons"

return {
	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			keys = {
				{
					"<tab>",
					function() return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>" end,
					expr = true,
					silent = true,
					mode = "i",
				},
				{ "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
				{ "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
			},
		},
	},

	-- Auto-completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"zbirenbaum/copilot-cmp",
			"LuaSnip",
		},
		opts = function()
			local cmp = require "cmp"
			local luasnip = require "luasnip"
			return {
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args) luasnip.lsp_expand(args.body) end,
				},
				sources = cmp.config.sources {
					{ name = "copilot", max_item_count = 3 },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "emoji" },
				},
				mapping = cmp.mapping.preset.insert {
					["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
					["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-b>"] = cmp.mapping.scroll_docs(-1),
					["<C-f>"] = cmp.mapping.scroll_docs(1),
					["<CR>"] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
					["<S-CR>"] = function(fallback)
						cmp.abort()
						fallback()
					end,
				},
				formatting = {
					fields = { "abbr", "kind" },
					format = function(entry, vim_item)
						if icons.kind[vim_item.kind] then
							vim_item.kind = icons.kind[vim_item.kind] .. vim_item.kind
						end
						if entry.source.name == "copilot" then
							vim_item.kind = icons.git.Copilot .. vim_item.kind
						end
						return vim_item
					end,
				},
				completion = {
					autocomplete = { cmp.TriggerEvent.InsertEnter, cmp.TriggerEvent.TextChanged },
					keyword_length = 0,
				},

				window = { completion = { cursorline = true } },
				experimental = { ghost_text = { hl_group = "LspCodeLens" } },
			}
		end,
	},

	-- Auto pairs
	{
		"echasnovski/mini.pairs",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.pairs",
		config = true,
	},

	-- Surrounding
	{
		"echasnovski/mini.surround",
		keys = { "s" },
		main = "mini.surround",
		config = true,
	},

	-- Rename symbols
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
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

	-- Refactoring code
	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>cr",
				function() require("refactoring").select_refactor {} end,
				mode = "v",
				desc = "Refactor",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		config = true,
	},
}
