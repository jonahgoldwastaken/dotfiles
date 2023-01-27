local util = require "util"
local icons = require "config.icons"

return {
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		dependencies = { "nvim-nonicons" },
		config = function() require("oil").setup() end,
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>" },
		},
	},

	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	cmd = "Neotree",
	-- 	dependencies = {
	-- 		"nvim-web-devicons",
	-- 		{
	-- 			-- only needed if you want to use the commands with "_with_window_picker" suffix
	-- 			"s1n7ax/nvim-window-picker",
	-- 			config = function()
	-- 				require("window-picker").setup {
	-- 					autoselect_one = true,
	-- 					include_current = false,
	-- 					show_prompt = false,
	-- 					selection_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
	-- 					filter_rules = {
	-- 						bo = {
	-- 							filetype = { "neo-tree", "neo-tree-popup", "notify" },
	-- 							buftype = { "terminal", "quickfix" },
	-- 						},
	-- 					},
	-- 				}
	-- 			end,
	-- 		},
	-- 	},
	-- 	branch = "main",
	-- 	keys = {
	-- 		{ "<leader>ee", "<cmd>Neotree toggle reveal filesystem<cr>", desc = "Toggle Filetree" },
	-- 		{ "<leader>eg", "<cmd>Neotree toggle git_status<cr>", desc = "Toggle Git tree" },
	-- 		{ "<leader>ef", "<cmd>Neotree focus<cr>", desc = "Focus Neotree" },
	-- 	},
	-- 	init = function() vim.g.neo_tree_remove_legacy_commands = 1 end,
	-- 	opts = {
	-- 		popup_border_style = "rounded",
	-- 		enable_git_status = true,
	-- 		enable_diagnostics = true,
	-- 		use_popups_for_input = false,
	-- 		default_component_configs = {
	-- 			indent = {
	-- 				indent_size = 2,
	-- 				padding = 1, -- extra padding on left hand side
	-- 				-- indent guides
	-- 				with_markers = true,
	-- 				indent_marker = icons.border.Vertical,
	-- 				last_indent_marker = icons.border.BottomLeft,
	-- 				highlight = "NeoTreeIndentMarker",
	-- 			},
	-- 			icon = {
	-- 				folder_closed = icons.documents.Folder,
	-- 				folder_open = icons.documents.OpenFolder,
	-- 				folder_empty = icons.documents.EmptyFolder,
	-- 				folder_empty_open = icons.documents.EmptyFolder,
	-- 				highlight = "NeoTreeFileIcon",
	-- 			},
	-- 			git_status = {
	-- 				symbols = {
	-- 					added = icons.git.Add,
	-- 					modified = icons.git.Mod,
	-- 					deleted = icons.git.Remove,
	-- 					renamed = icons.git.Rename,
	-- 					untracked = icons.ui.QuestionMarkCircle,
	-- 					ignored = icons.ui.SlashCircle,
	-- 					unstaged = icons.ui.EmptyCircle,
	-- 					staged = icons.ui.PassCircle,
	-- 					conflict = icons.ui.ErrorCircle,
	-- 				},
	-- 			},
	-- 		},
	-- 		window = {
	-- 			position = "right",
	-- 			width = 35,
	-- 			mapping_options = {
	-- 				noremap = true,
	-- 				nowait = false,
	-- 			},
	-- 			mappings = {
	-- 				["<space>"] = "noop",
	-- 				["<C-v>"] = "open_vsplit",
	-- 				["<C-s>"] = "open_split",
	-- 			},
	-- 		},
	-- 		filesystem = {
	-- 			follow_current_file = false,
	-- 			bind_to_cwd = true,
	-- 			scan_mode = "deep",
	-- 			group_empty_dirs = true,
	-- 			hijack_netrw_behavior = "disabled",
	-- 			use_libuv_file_watcher = false,
	-- 			cwd_target = {
	-- 				sidebar = "tab",
	-- 				current = "window",
	-- 			},
	-- 		},
	-- 	},
	-- },

	{
		"windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
		opts = {
			colors_devicons = false,
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"debugloop/telescope-undo.nvim",
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
						"Function",
						"Method",
						"Constructor",
						"Interface",
						"Module",
						"Struct",
						"Trait",
						"Field",
						"Property",
					},
				}),
				desc = "Goto Symbol",
			},
			{ "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo tree" },
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
							anchor = "N",
							width = 60,
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
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
					},
					undo = {
						use_delta = true,
						side_by_side = true,
						layout_strategy = "vertical",
						layout_config = {
							preview_height = 0.8,
						},
					},
				},
			}
			telescope.load_extension "fzf"
			telescope.load_extension "noice"
			telescope.load_extension "undo"
		end,
	},

	{
		"phaazon/hop.nvim",
		keys = {
			{
				"f",
				"<cmd>HopChar1AC<cr>",
				{ "n", "v" },
				remap = true,
			},
			{
				"F",
				"<cmd>HopChar1BC<cr>",
				{ "n", "v" },
				{ remap = true },
			},
			{
				"t",
				function()
					require("hop").hint_char1 {
						direction = require("hop.hint").HintDirection.AFTER_CURSOR,
						current_line_only = true,
						hint_offset = -1,
					}
				end,
				{ "n", "v" },
				{ remap = true },
			},
			{
				"T",
				function()
					require("hop").hint_char1 {
						direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
						hint_offset = -1,
					}
				end,
				{ "n", "v" },
				{ remap = true },
			},
		},
		opts = {
			create_hl_autocmd = false,
		},
	},

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
					filetypes = { "TelescopePrompt", "NvimTree", "neo-tree", "lazy", "mason" },
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
				["<leader>d"] = { name = "+dap" },
				["<leader>e"] = { name = "+explorer" },
				["<leader>f"] = { name = "+file" },
				["<leader>g"] = { name = "+git" },
				["<leader>h"] = { name = "+help" },
				["<leader>n"] = { name = "+noice" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>t"] = { name = "+tag" },
				["<leader>u"] = { name = "+undo" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			}
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		config = function()
			require("gitsigns").setup {
				signs = {
					add = {
						hl = "GitSignsAdd",
						text = "│",
						numhl = "GitSignsAddNr",
						linehl = "GitSignsAddLn",
					},
					change = {
						hl = "GitSignsChange",
						text = "│",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
					delete = {
						hl = "GitSignsDelete",
						text = "_",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					topdelete = {
						hl = "GitSignsDelete",
						text = "‾",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					changedelete = {
						hl = "GitSignsChange",
						text = "~",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000,
				preview_config = {
					-- Options passed to nvim_open_win
					border = "rounded",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			}
		end,
	},

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{
				"<leader>xx",
				"<cmd>TroubleToggle workspace_diagnostics<cr>",
				desc = "Document Diagnostics (Trouble)",
			},
		},
		opts = { auto_open = false, use_diagnostic_signs = true },
	},

	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		config = function()
			require("illuminate").configure {
				delay = 200,
				filetypes_allowlist = {
					"javascript",
					"javascriptreact",
					"go",
					"rust",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
					"lua",
				},
			}
		end,
    -- stylua: ignore
    keys = {
      { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "Next Reference", },
      { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "Prev Reference" },
    },
	},

	{ "nacro90/numb.nvim", event = "BufReadPost", config = true },

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			window = {
				width = 90,
				options = {
					signcolumn = "no",
					relativenumber = false,
					number = false,
				},
			},
			plugins = {
				options = {
					enabled = true,
					ruler = true,
					showcmd = false,
				},
				twilight = { enabled = false },
				gitsigns = { enabled = true },
				kitty = {
					enabled = false,
					font = "18",
				},
			},
			on_open = function() require("lualine").hide {} end,
			on_close = function() require("lualine").hide { unhide = true } end,
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	-- {
	-- 	"shortcuts/no-neck-pain.nvim",
	-- 	cmd = "NoNeckPain",
	-- 	keys = { { "<leader>z", "<cmd>NoNeckPain<cr>", desc = "No Neck Pain" } },
	-- 	opts = {
	-- 		toggleMapping = false,
	-- 		buffers = {
	-- 			wo = {
	-- 				cursorline = false,
	-- 				cursorcolumn = false,
	-- 				number = false,
	-- 				relativenumber = false,
	-- 				foldenable = false,
	-- 				list = false,
	-- 				wrap = true,
	-- 				linebreak = true,
	-- 			},
	-- 		},
	-- 	},
	-- },
}
