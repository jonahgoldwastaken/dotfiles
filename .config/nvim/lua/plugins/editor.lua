local util = require "util"
local icons = require "util.icons"

return {
	-- File explorer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-web-devicons" },
		config = true,
		cmd = "Oil",
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>", "n" },
		},
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"nvim-web-devicons",
		},
		cmd = "Telescope",
		keys = {
			{
				"<leader>ff",
				util.telescope "files",
				desc = "Find files (root dir)",
			},
			{
				"<leader>fF",
				util.telescope("files", { cwd = false }),
				desc = "Find files (cwd)",
			},
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
			{
				"<leader>/",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Search text in buffer",
			},
			{
				"<leader>sb",
				"<cmd>Telescope current_buffer_fuzzy_find<cr>",
				desc = "Search text in buffer",
			},
			{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
			{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep (root dir)" },
			{ "<leader>xd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
			{
				"<leader>ss",
				util.telescope("lsp_document_symbols", {
					symbols = {
						"Class",
						"Constructor",
						"Enum",
						"Field",
						"Function",
						"Interface",
						"Method",
						"Module",
						"Property",
						"Struct",
						"Trait",
					},
				}),
				desc = "Goto Symbol",
			},
			{
				"<leader>sw",
				util.telescope "lsp_workspace_symbols",
				desc = "Goto Symbol (workspace)",
			},
			{ "<leader>ha", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>hc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>hf", "<cmd>Telescope filetypes<cr>", desc = "File Types" },
			{ "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>ho", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>hs", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
			{ "<leader>ht", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
		},
		config = function()
			local telescope = require "telescope"
			telescope.setup {
				defaults = {
					layout_strategy = "horizontal",
					layout_config = {
						prompt_position = "top",
						center = {
							anchor = "CENTER",
							width = 0.75,
							height = 0.8,
						},
					},
					sorting_strategy = "ascending",
					winblend = 0,
					color_devicons = false,
					prompt_prefix = icons.chevron.Right,
					selection_caret = icons.triangle.Right,
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
							["<c-t>"] = function(...)
								return require("trouble.providers.telescope").open_with_trouble(...)
							end,
							["<C-i>"] = function() util.telescope("find_files", { no_ignore = true })() end,
							["<C-h>"] = function() util.telescope("find_files", { hidden = true })() end,
							["<C-Down>"] = function(...)
								return require("telescope.actions").cycle_history_next(...)
							end,
							["<C-Up>"] = function(...)
								return require("telescope.actions").cycle_history_prev(...)
							end,
						},
					},
					preview = {
						treesitter = true,
					},
				},
				pickers = {
					current_buffer_fuzzy_find = {
						wrap_results = false,
						theme = "dropdown",
					},
					find_files = {
						previewer = false,
						layout_strategy = "center",
					},
					git_files = {
						previewer = false,
						layout_strategy = "center",
					},
					buffers = {
						previewer = false,
						layout_strategy = "center",
					},
					lsp_references = {
						fname_width = 160,
					},
					lsp_document_symbols = {
						wrap_results = false,
						theme = "dropdown",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
				},
			}
			telescope.load_extension "fzf"
			telescope.load_extension "hbac"
		end,
	},

	-- Bracket navigation
	{
		"echasnovski/mini.bracketed",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.bracketed",
		config = true,
	},

	-- Line navigation preview
	{ "nacro90/numb.nvim", event = { "BufReadPost", "BufNewFile" }, config = true },

	-- Buffer management
	{
		"axkirillov/hbac.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>bt", "<cmd>Hbac toggle_pin<cr>", desc = "Toggle pin" },
			{ "<leader>bp", "<cmd>Hbac pin_all<cr>", desc = "Pin all" },
			{ "<leader>bu", "<cmd>Hbac unpin_all<cr>", desc = "Unpin all" },
			{ "<leader>bc", "<cmd>Hbac close_unpinned<cr>", desc = "Close unpinned" },
			{ "<leader>bh", "<cmd>Telescope hbac buffers<cr>", desc = "Buffer list (Hbac)" },
		},
		event = "VeryLazy",
		config = true,
	},

	-- Better quickfix list
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{
				"<leader>xx",
				"<cmd>TroubleToggle<cr>",
				desc = "Toggle Trouble",
			},
			{
				"<leader>xw",
				"<cmd>TroubleToggle workspace_diagnostics<cr>",
				desc = "Workspace Diagnostics (Trouble)",
			},
			{
				"<leader>xq",
				"<cmd>TroubleToggle quickfix<cr>",
				desc = "Quickfix (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>TroubleToggle loclist<cr>",
				desc = "Location list (Trouble)",
			},
		},
		opts = { auto_open = false, use_diagnostic_signs = true },
	},

	-- WhichKey
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require "which-key"
			wk.setup {
				plugins = { spelling = true },
				key_labels = { ["<leader>"] = "SPC" },
				disable = {
					buftypes = {},
					filetypes = { "TelescopePrompt", "lazy", "mason" },
				},
			}
			wk.register {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>e"] = { name = "+explorer" },
				["<leader>f"] = { name = "+file" },
				["<leader>g"] = { name = "+git" },
				["<leader>h"] = { name = "+help" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			}
		end,
	},

	-- Hints for better VIM keybinding usage
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
		opts = {
			allow_different_key = true,
			notification = false,
		},
	},

	-- Git
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		opts = {},
		cmd = { "Neogit" },
	},

	{
		"folke/zen-mode.nvim",
		keys = {
			{ "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
		},
		opts = {
			options = {
				enabled = true,
				ruler = false,
				showcmd = false,
				laststatus = 0,
			},
			plugins = {
				gitsigns = { enabled = true },
				alacritty = { enabled = true, font_size = 20 },
			},
		},
	},
}
