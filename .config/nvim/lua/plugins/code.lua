local icons = require "config.icons"

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0
		and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
	-- snippets
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
					{ name = "copilot", max_item_count = 3 },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "emoji" },
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						require("copilot_cmp.comparators").prioritize,
						function(a1, a2)
							local types = require "cmp.types"
							local k1 = a1:get_kind()
							k1 = k1 == types.lsp.CompletionItemKind.Text and 100 or k1
							local k2 = a2:get_kind()
							k2 = k2 == types.lsp.CompletionItemKind.Text and 100 or k2
							if k1 ~= k2 then
								local diff = k1 - k2
								return diff < 0
							end
						end,
						compare.offset,
						-- compare.scopes,
						compare.exact,
						compare.score,
						compare.recently_used,
						compare.locality,
						-- compare.kind,
						compare.sort_text,
						compare.length,
						compare.order,
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

	-- auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		main = "mini.pairs",
		config = true,
	},

	-- surround
	{
		"echasnovski/mini.surround",
		keys = { "s" },
		main = "mini.surround",
		config = true,
	},

	-- rename symbols
	{
		"smjonas/inc-rename.nvim",
		cmd = "IncRename",
		config = true,
	},

	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		main = "mini.comment",
		opts = {},
	},

	-- -- better text-objects
	-- {
	-- 	"echasnovski/mini.ai",
	-- 	keys = {
	-- 		{ "a", mode = { "x", "o" } },
	-- 		{ "i", mode = { "x", "o" } },
	-- 	},
	-- 	main = "mini.ai",
	-- 	opts = function()
	-- 		-- add treesitter jumping
	-- 		---@param capture string
	-- 		---@param start boolean
	-- 		---@param down boolean
	-- 		local function jump(capture, start, down)
	-- 			local rhs = function()
	-- 				local parser = vim.treesitter.get_parser()
	-- 				if not parser then
	-- 					return vim.notify("No treesitter parser for the current buffer", vim.log.levels.ERROR)
	-- 				end
	--
	-- 				local query = vim.treesitter.get_query(vim.bo.filetype, "textobjects")
	-- 				if not query then
	-- 					return vim.notify("No textobjects query for the current buffer", vim.log.levels.ERROR)
	-- 				end
	--
	-- 				local cursor = vim.api.nvim_win_get_cursor(0)
	--
	-- 				---@type {[1]:number, [2]:number}[]
	-- 				local locs = {}
	-- 				for _, tree in ipairs(parser:trees()) do
	-- 					for capture_id, node, _ in query:iter_captures(tree:root(), 0) do
	-- 						if query.captures[capture_id] == capture then
	-- 							local range = { node:range() } ---@type number[]
	-- 							local row = (start and range[1] or range[3]) + 1
	-- 							local col = (start and range[2] or range[4]) + 1
	-- 							if down and row > cursor[1] or (not down) and row < cursor[1] then
	-- 								table.insert(locs, { row, col })
	-- 							end
	-- 						end
	-- 					end
	-- 				end
	-- 				return pcall(vim.api.nvim_win_set_cursor, 0, down and locs[1] or locs[#locs])
	-- 			end
	--
	-- 			local c = capture:sub(1, 1):lower()
	-- 			local lhs = (down and "]" or "[") .. (start and c or c:upper())
	-- 			local desc = (down and "Next " or "Prev ")
	-- 				.. (start and "start" or "end")
	-- 				.. " of "
	-- 				.. capture:gsub("%..*", "")
	-- 			vim.keymap.set("n", lhs, rhs, { desc = desc })
	-- 		end
	--
	-- 		for _, capture in ipairs { "function.outer", "class.outer" } do
	-- 			for _, start in ipairs { true, false } do
	-- 				for _, down in ipairs { true, false } do
	-- 					jump(capture, start, down)
	-- 				end
	-- 			end
	-- 		end
	-- 	end,
	-- },

	-- color codes
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		main = "colorizer",
		config = true,
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
		"echasnovski/mini.splitjoin",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.splitjoin",
		config = true,
	},

	{
		"sQVe/sort.nvim",
		config = true,
	},

	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{
				"]t",
				function() require("todo-comments").jump_next() end,
				desc = "Next todo comment",
			},
			{
				"[t",
				function() require("todo-comments").jump_prev() end,
				desc = "Previous todo comment",
			},
			{
				"<leader>xt",
				"<cmd>TodoTrouble<cr>",
				desc = "Todo (Trouble)",
			},
			{
				"<leader>xT",
				"<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",
				desc = "Todo/Fix/Fixme (Trouble)",
			},
			{ "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
		},
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
