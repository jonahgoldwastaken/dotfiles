local icons = require "config.icons"

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", config = true },
			{ "lvimuser/lsp-inlayhints.nvim", config = true },
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = { "mason.nvim" },
				opts = {
					ensure_installed = {
						"tsserver",
						"jsonls",
						"yamlls",
						"taplo",
						"html",
						"emmet_ls",
						"tailwindcss",
						"lua_ls",
						"rust_analyzer",
					},
				},
			},
			"hrsh7th/cmp-nvim-lsp",
			"SmiteshP/nvim-navic",
		},
		config = function()
			require("util").on_attach(function(client, buffer)
				-- if client.name ~= "tsserver" then require("lsp-inlayhints").on_attach(client, buffer) end
				require("plugins.lsp.format").on_attach(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			-- diagnostics
			for name, icon in pairs(require("config.icons").diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end

			vim.diagnostic.config {
				underline = true,
				virtual_text = { spacing = 4, prefix = icons.ui.FilledCircle },
				severity_sort = true,
			}

			local servers = require "plugins.lsp.servers"
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			for server, opts in pairs(servers) do
				opts.capabilities = capabilities
				require("lspconfig")[server].setup(opts)
			end
		end,
	},

	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			local nls = require "null-ls"
			nls.setup {
				debounce = 150,
				save_after_format = false,
				sources = {
					nls.builtins.formatting.fish_indent,
					nls.builtins.code_actions.gitsigns,
				},
			}

			require("mason-null-ls").setup {
				automatic_installation = true,
				ensure_installed = {
					"prettierd",
					"stylua",
				},
				handlers = {
					function(source_name, methods)
						require "mason-null-ls.automatic_setup"(source_name, methods)
					end,
					eslint_d = function() nls.register(nls.builtins.formatting.eslint_d) end,
					prettierd = function()
						if nls.is_registered "eslint_d" then
							return
						else
							nls.register(nls.builtins.formatting.prettierd.with {
								extra_filetypes = {
									"markdown",
									"astro",
									"svelte",
								},
							})
						end
					end,
				},
			}
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = function()
			local opts = {
				PATH = "prepend",
				ui = {
					border = "rounded",
					keymaps = {
						toggle_server_expand = "<CR>",
						install_server = "i",
						update_server = "u",
						check_server_version = "c",
						update_all_servers = "U",
						check_outdated_servers = "C",
						uninstall_server = "X",
					},
					check_outdated_servers_on_open = true,
				},
				log_level = vim.log.levels.INFO,
			}

			if vim.env.TERM ~= "alacritty" then
				opts.ui.icons = require("nvim-nonicons.extentions.mason").icons
			end

			return opts
		end,
	},

	"b0o/schemastore.nvim",
}
