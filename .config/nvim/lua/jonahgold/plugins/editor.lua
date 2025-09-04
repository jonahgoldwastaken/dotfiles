local util = require "jonahgold.util"
local icons = require "jonahgold.util.icons"

return {
	-- File explorer
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-web-devicons" },
		lazy = vim.fn.argc(-1) == 0,
		cmd = "Oil",
		keys = {
			{ "<leader>e", "<cmd>Oil<cr>", "n" },
		},
		config = true,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release && cmake --install build --prefix build",
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
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word" },
			{
				"<leader>fd",
				function() require("telescope.builtin").find_files { cwd = "~/.config" } end,
				desc = "Find dotfiles",
			},
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
				"<leader>sr",
				function() require("telescope.builtin").grep_string { search = vim.fn.input "Grep > " } end,
				desc = "Search for files with word",
			},
			{
				"<leader>ss",
				util.telescope "lsp_document_symbols",
				desc = "Goto Symbol",
			},
			{
				"<leader>sw",
				util.telescope "lsp_workspace_symbols",
				desc = "Goto Symbol (workspace)",
			},
			{ "<leader>ha", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
			{ "<leader>hc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
			{ "<leader>hk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{ "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
			{ "<leader>ho", "<cmd>Telescope vim_options<cr>", desc = "Options" },
			{ "<leader>ht", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
		},
		config = function()
			local telescope = require "telescope"
			local trouble = require "trouble.sources.telescope"

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
					color_devicons = false,
					prompt_prefix = icons.chevron.Right,
					selection_caret = icons.triangle.Right,
					mappings = {
						n = {
							["<C-t>"] = trouble.open,
						},
						i = {
							["<C-t>"] = trouble.open,
							["<C-i>"] = function() util.telescope("find_files", { no_ignore = true })() end,
							["<C-h>"] = function() util.telescope("find_files", { hidden = true })() end,
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
		end,
	},

	-- Bracket navigation
	{
		"echasnovski/mini.bracketed",
		event = { "BufReadPost", "BufNewFile" },
		main = "mini.bracketed",
		config = true,
	},

	-- Harpoon
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>a",
				function() require("harpoon"):list():add() end,
				desc = "Add file to list",
			},
			{
				"<leader>fh",
				function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
				desc = "Harpoon list",
			},
			{
				"<leader>hp",
				function() require("harpoon"):list():prev { ui_nav_wrap = true } end,
				desc = "Harpoon Previous",
			},
			{
				"<leader>hn",
				function() require("harpoon"):list():next { ui_nav_wrap = true } end,
				desc = "Harpoon Next",
			},
		},
		config = true,
	},

	-- Better quickfix list
	{
		"folke/trouble.nvim",
		cmd = { "Trouble" },
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Toggle Trouble",
			},
			{
				"<leader>xw",
				"<cmd>Trouble workspace_diagnostics toggle<cr>",
				desc = "Workspace Diagnostics (Trouble)",
			},
			{
				"<leader>xq",
				"<cmd>Trouble quickfix toggle<cr>",
				desc = "Quickfix (Trouble)",
			},
			{
				"<leader>xl",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location list (Trouble)",
			},
		},
		opts = { use_diagnostic_signs = true },
	},

	-- WhichKey
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		dependencies = { "echasnovski/mini.icons" },
		config = function()
			local wk = require "which-key"
			wk.setup {
				plugins = { spelling = true },
				icons = {
					keys = { ["<leader>"] = "SPC" },
				},
				disable = {
					buftypes = {},
					filetypes = { "TelescopePrompt", "lazy", "mason" },
				},
			}
			wk.add {
				{
					mode = { "n", "v" },
					{ "g", { group = "goto" } },
					{ "]", { group = "next" } },
					{ "[", { group = "prev" } },
					{ "<leader><tab>", { group = "tabs" } },
					{ "<leader>b", { group = "buffer" } },
					{ "<leader>c", { group = "code" } },
					{ "<leader>e", { group = "explorer" } },
					{ "<leader>f", { group = "file" } },
					{ "<leader>g", { group = "gitlab" } },
					{ "<leader>h", { group = "help" } },
					{ "<leader>o", { group = "obsidian" } },
					{ "<leader>q", { group = "quit/session" } },
					{ "<leader>s", { group = "search" } },
					{ "<leader>w", { group = "windows" } },
					{ "<leader>x", { group = "diagnostics/quickfix" } },
				},
			}
		end,
	},

	{
		"folke/zen-mode.nvim",
		keys = {
			{ "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
		},
		cmd = "ZenMode",
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

	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = "markdown",
		keys = {
			{ "<leader>zr", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle RenerMarkdown" },
		},
		opts = {
			enabled = vim.uv.cwd():find "vaults" == false,
		},
	},

	{
		"monaqa/dial.nvim",
		keys = {
			{
				"<C-a>",
				function() require("dial.map").manipulate("increment", "normal") end,
				mode = "n",
				desc = "Increment",
				noremap = true,
			},
			{
				"<C-x>",
				function() require("dial.map").manipulate("decrement", "normal") end,
				mode = "n",
				desc = "Decrement",
				noremap = true,
			},
			{
				"g<C-a>",
				function() require("dial.map").manipulate("increment", "gnormal") end,
				mode = "n",
				desc = "Increment",
				noremap = true,
			},
			{
				"g<C-x>",
				function() require("dial.map").manipulate("decrement", "gnormal") end,
				mode = "n",
				desc = "Decrement",
				noremap = true,
			},
			{
				"<C-a>",
				function() require("dial.map").manipulate("increment", "visual") end,
				mode = "v",
				desc = "Increment",
				noremap = true,
			},
			{
				"<C-x>",
				function() require("dial.map").manipulate("decrement", "visual") end,
				mode = "v",
				desc = "Decrement",
				noremap = true,
			},
			{
				"g<C-a>",
				function() require("dial.map").manipulate("increment", "gvisual") end,
				mode = "v",
				desc = "Increment",
				noremap = true,
			},
			{
				"g<C-x>",
				function() require("dial.map").manipulate("decrement", "gvisual") end,
				mode = "v",
				desc = "Decrement",
				noremap = true,
			},
		},
	},
}
