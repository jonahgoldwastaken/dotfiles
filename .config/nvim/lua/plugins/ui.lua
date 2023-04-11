local icons = require "config.icons"

return {
	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>nd",
				function() require("notify").dismiss { silent = true, pending = true } end,
				desc = "Delete all Notifications",
			},
		},
		config = function(_, opts)
			if vim.env.TERM ~= "alacritty" then
				opts.icons = require("nvim-nonicons/extentions/nvim-notify").icons
			end
			require("notify").setup(opts)
		end,
		opts = {
			timeout = 2000,
			max_height = function() return math.floor(vim.o.lines * 0.75) end,
			max_width = function() return math.floor(vim.o.columns * 0.75) end,
			render = "simple",
			on_open = function(win)
				if vim.api.nvim_win_is_valid(win) then
					vim.api.nvim_win_set_config(win, {
						border = "rounded",
					})
				end
			end,
		},
	},

	{
		"stevearc/dressing.nvim",
		opts = {
			win_options = {
				winblend = 0,
				wrap = false,
			},
		},
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load { plugins = { "dressing.nvim" } }
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load { plugins = { "dressing.nvim" } }
				return vim.ui.input(...)
			end
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("lualine").setup {
				options = {
					icons_enabled = true,
					theme = "auto",
					section_separators = "",
					component_separators = { left = icons.border.Vertical, right = icons.border.Vertical },
					globalstatus = true,
					disabled_filetypes = {
						statusline = { "alpha", "lazy", "mason", "TelescopePrompt" },
					},
				},
				extensions = { "nvim-tree", "neo-tree", "quickfix", "nvim-dap-ui" },
				sections = {
					lualine_a = { "mode" },
					lualine_b = {
						{ "branch", icon = icons.git.Branch },
						{
							"diff",
							colored = false,
							symbols = {
								added = icons.git.Add,
								modified = icons.git.Mod,
								removed = icons.git.Remove,
							},
						},
					},
					lualine_c = {
						{ "filename", path = 1 },
						{
							function() return require("nvim-navic").get_location() end,
							cond = function()
								return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
							end,
						},
					},
					lualine_x = {
						{
							require("noice").api.status.mode.get,
							cond = require("noice").api.status.mode.has,
							color = { fg = require("octocolors.colors").get_colors().colors.orange },
						},
						{
							function()
								local key = require("grapple").key()
								return "[" .. key .. "]"
							end,
							icon = { icons.ui.Tag },
							cond = function() return package.loaded["grapple"] and require("grapple").exists() end,
						},
						{ function() return require("copilot_status").status_string() end },
						{
							"diagnostics",
							source = { "nvim_diagnostic" },
							sections = { "error" },
							colored = false,
							always_visible = true,
							symbols = { error = icons.diagnostics.Error },
							separator = "",
						},
						{
							"diagnostics",
							source = { "nvim" },
							sections = { "warn" },
							colored = false,
							symbols = { warn = icons.diagnostics.Warn },
							always_visible = true,
							padding = { right = 1 },
						},
					},
					lualine_y = {
						"o:encoding",
						{
							"fileformat",
							symbols = {
								unix = "lf",
								dos = "crlf",
								mac = "cr",
							},
						},
						{
							"filetype",
							colored = false,
							icon = { icons.misc.File },
						},
					},
					lualine_z = {
						"searchcount",
						"location",
						{
							function() return tostring(vim.fn.wordcount().words) end,
							cond = function() return vim.bo.filetype == "markdown" end,
						},
						{
							require("noice").api.status.command.get,
							cond = function()
								return package.loaded["noice"] and require("noice").api.status.command.has()
							end,
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			}
		end,
	},

	-- active indent guide and indent text objects
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "NvimTree", "neo-tree", "Trouble", "lazy", "mason" },
				callback = function() vim.b.miniindentscope_disable = true end,
			})
			require("mini.indentscope").setup {
				symbol = "▏",
				draw = {
					delay = 25,
					animation = require("mini.indentscope").gen_animation.none(),
				},
				options = { try_as_border = true },
			}
		end,
	},

	-- noicer ui
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["cmp.entry.get_documentation"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
				progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = {
						{ icons.ui.Check,            hl_group = "NoiceLspProgressSpinner" },
						{ "{data.progress.title} ",  hl_group = "NoiceLspProgressTitle" },
						{ "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
					},
					throttle = 1000 / 30, -- frequency to update lsp progress message
					view = "mini",
				},
				documentation = {
					view = "hover",
					opts = {
						lang = "markdown",
						replace = true,
						render = "plain",
						border = {
							style = "rounded",
							padding = { 0, 1 },
						},
						format = { "{message}" },
						win_options = { concealcursor = "n", conceallevel = 3 },
					},
				},
			},
			presets = {
				bottom_search = true,
				long_message_to_split = true,
				inc_rename = true,
				command_palette = true,
			},
			cmdline = {
				enabled = true,
				opts = {},
				format = {
					cmdline = { pattern = "^:", icon = icons.chevron.Right, lang = "vim" },
					search_down = {
						kind = "search",
						pattern = "^/",
						icon = icons.ui.Search .. icons.arrow.Down,
						lang = "regex",
					},
					search_up = {
						kind = "search",
						pattern = "^%?",
						icon = icons.ui.Search .. icons.arrow.Up,
						lang = "regex",
					},
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = icons.ui.QuestionMarkCircle },
					calculator = { pattern = "^=", icon = icons.type.Number, lang = "vimnormal" },
					input = {},
				},
			},
			views = {},
			routes = {
				{
					filter = {
						any = {
							{ event = "msg_show", kind = "",     find = "[w]" },
							{ event = "notify",   kind = "info", find = "Toggling" },
						},
					},
					opts = {
						skip = true,
					},
				},
			},
			format = {
				spinner = {
					name = "circleQuarters",
					hl_group = nil,
				},
			},
		},
		-- stylua: ignore
		keys = {
			{
				"<S-Enter>",
				function() require("noice").redirect(vim.fn.getcmdline()) end,
				mode = "c",
				desc =
				"Redirect Cmdline"
			},
			{
				"<leader>nl",
				function() require("noice").cmd("last") end,
				desc =
				"Noice Last Message"
			},
			{
				"<leader>nh",
				function() require("noice").cmd("history") end,
				desc =
				"Noice History"
			},
			{ "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
			{
				"<c-f>",
				function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
				silent = true,
				expr = true
			},
			{
				"<c-b>",
				function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
				silent = true,
				expr = true
			},
		},
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-web-devicons" },
		config = function()
			local dashboard = require "alpha.themes.dashboard"
			dashboard.section.buttons.val = {
				dashboard.button("f", icons.ui.Search .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button(
					"n",
					icons.documents.NewFile .. " New file",
					":ene <BAR> startinsert <CR>"
				),
				dashboard.button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", icons.ui.Telescope .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("c", icons.ui.Gear .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button(
					"s",
					icons.ui.History .. " Restore Session",
					[[:lua require("persistence").load() <cr>]]
				),
				dashboard.button("m", icons.misc.Package .. " Mason", ":Mason<CR>"),
				dashboard.button("l", icons.misc.Sleep .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", icons.ui.SignOut .. " Quit", ":qa<CR>"),
			}
			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end
			dashboard.section.footer.opts.hl = "Type"
			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
			dashboard.opts.layout[1].val = 8
			vim.b.miniindentscope_disable = true

			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function() require("lazy").show() end,
				})
			end

			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					dashboard.section.footer.val = icons.ui.Fire
							.. " Neovim loaded "
							.. stats.count
							.. " plugins in "
							.. ms
							.. "ms"
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},

	-- icons
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup {
				default = false,
				color_icons = false,
				override = {
					default_icon = {
						icon = require("config.icons").documents.File,
						color = require("octocolors.colors").get_colors().colors.fg,
						name = "Default",
					},
				},
			}
		end,
	},

	-- nicer icons
	{
		"yamatsum/nvim-nonicons",
		dependencies = { "nvim-web-devicons" },
		cond = function() return vim.env.TERM ~= "alacritty" end,
		config = function()
			local nonicons = require "nvim-nonicons"
			nonicons.setup()
			require("nvim-web-devicons").set_default_icon(
				nonicons.get "file",
				require("octocolors.colors").get_colors().colors.fg
			)
		end,
		event = "VeryLazy",
	},

	-- ui components
	"MunifTanjim/nui.nvim",
}
