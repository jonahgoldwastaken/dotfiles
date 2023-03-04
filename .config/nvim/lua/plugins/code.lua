local icons = require "config.icons"

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0
		and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},

	-- auto completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-emoji",
			"dmitmel/cmp-cmdline-history",
			"zbirenbaum/copilot-cmp",
			"LuaSnip",
		},
		config = function()
			local cmp = require "cmp"
			local luasnip = require "luasnip"
			local compare = require "cmp.config.compare"
			local kind_icons = icons.kind

			cmp.setup {
				preselect = cmp.PreselectMode.None,
				snippet = {
					expand = function(args) luasnip.lsp_expand(args.body) end,
				},
				mapping = cmp.mapping.preset.insert {
					["<esc>"] = cmp.mapping(function(fallback)
						if not cmp.visible() then return fallback() end
						cmp.abort()
					end, { "s" }),
					["<C-Space>"] = cmp.mapping.complete { config = { completion = { keyword_length = 0 } } },
					["<C-b>"] = cmp.mapping.scroll_docs(-1),
					["<C-f>"] = cmp.mapping.scroll_docs(1),
					["<CR>"] = cmp.mapping.confirm { select = false, behavior = cmp.ConfirmBehavior.Replace },
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				formatting = {
					fields = { "abbr", "kind" },
					format = function(entry, vim_item)
						if kind_icons[vim_item.kind] then
							vim_item.kind = kind_icons[vim_item.kind] .. vim_item.kind
						end
						if entry.source.name == "copilot" then
							vim_item.kind = icons.git.Copilot .. vim_item.kind
						end
						return vim_item
					end,
				},
				sources = cmp.config.sources {
					{ name = "copilot", priority = 10, max_item_count = 3 },
					{ name = "nvim_lsp", priority = 5 },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "emoji" },
				},
				sorting = {
					comparators = {
						require("copilot_cmp.comparators").prioritize,
						require("copilot_cmp.comparators").score,
						compare.offset,
						compare.exact,
						compare.score,
						compare.recently_used,
						compare.locality,
					},
				},
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
					keyword_length = 1,
				},
				window = {
					completion = {
						cursorline = true,
						border = "rounded",
						winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
					},
				},
				experimental = {
					ghost_text = {
						hl_group = "LspCodeLens",
					},
				},
			}
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		event = { "BufReadPost", "BufNewFile" },
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
		event = { "BufReadPost", "BufNewFile" },
		module = true,
		opts = {
			icons = {
				idle = " ",
				error = " ",
				offline = " ",
				warning = " ",
				loading = " ",
			},
			debug = true,
		},
	},

	-- auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function() require("mini.pairs").setup {} end,
	},

	-- surround
	{
		"echasnovski/mini.surround",
		keys = { "s" },
		config = function() require("mini.surround").setup {} end,
	},

	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	-- comments
	{ "JoosepAlviste/nvim-ts-context-commentstring" },

	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup {
				hooks = {
					pre = function() require("ts_context_commentstring.internal").update_commentstring {} end,
				},
			}
		end,
	},

	-- better text-objects
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- no need to load the plugin, since we only need its queries
					require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
				end,
			},
		},
		config = function()
			local ai = require "mini.ai"
			ai.setup {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
	},

	-- color codes
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		config = function() require("colorizer").setup() end,
	},

	-- better increase/descrease
	{
		"monaqa/dial.nvim",
		keys = {
			{
				"<C-a>",
				function() return require("dial.map").inc_normal() end,
				expr = true,
			},
			{
				"<C-x>",
				function() return require("dial.map").dec_normal() end,
				expr = true,
			},
		},
		config = function()
			local augend = require "dial.augend"
			require("dial.config").augends:register_group {
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.date.alias["%Y/%m/%d"],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
				},
			}
		end,
	},

	{
		"Wansmer/treesj",
		keys = {
			{ "<leader>j", "<cmd>TSJToggle<cr>" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},

	{
		"sQVe/sort.nvim",
		config = true,
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
			{
				"<leader>xT",
				"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
				desc = "Todo/Fix/Fixme (Trouble)",
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
		},
		config = true,
		opts = {
			keywords = {
				FIX = {
					icon = icons.ui.Dashboard, -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
				},
				TODO = { icon = icons.ui.Check, color = "todo" },
				HACK = { icon = icons.ui.Fire, color = "warning" },
				WARN = { icon = icons.diagnostics.Warn, color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = icons.ui.Stopwatch, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = icons.ui.Note, color = "hint", alt = { "INFO" } },
				TEST = { icon = icons.ui.TaskList, color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			highlight = {
				keyword = "bg",
				after = "fg",
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg" },
				warning = { "DiagnosticWarn", "WarningMsg" },
				info = { "DiagnosticInfo" },
				hint = { "DiagnosticHint" },
				todo = { "Todo" },
				default = { "Identifier" },
				test = { "Identifier" },
			},
		},
	},
}
