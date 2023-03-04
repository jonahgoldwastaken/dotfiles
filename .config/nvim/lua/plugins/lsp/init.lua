local icons = require "config.icons"

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", config = true },
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"SmiteshP/nvim-navic",
		},
		config = function()
			require("util").on_attach(function(client, buffer)
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

			require("mason-lspconfig").setup {}

			for server, opts in pairs(servers) do
				opts.capabilities = capabilities
				require("lspconfig")[server].setup(opts)
			end
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			local nls = require "null-ls"
			require("mason-null-ls").setup {
				ensure_installed = nil,
				automatic_installation = false,
				automatic_setup = true,
			}
			require("mason-null-ls").setup_handlers {
				function(source_name, methods)
					require "mason-null-ls.automatic_setup"(source_name, methods)
				end,

				prettier = function()
					nls.register(nls.builtins.formatting.prettier.with {
						extra_filetypes = {
							"markdown",
							"astro",
							"svelte",
						},
					})
				end,

				eslint_d = function()
					local opts = {
						extra_filetypes = { "astro", "svelte" },
						condition = function(utils)
							return utils.root_has_file { ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" }
						end,
					}
					nls.register(nls.builtins.diagnostics.eslint_d.with(opts))
					nls.register(nls.builtins.code_actions.eslint_d.with(opts))
					nls.register(nls.builtins.code_actions.gitsigns)
				end,
			}
			nls.setup {
				debounce = 150,
				save_after_format = false,
				sources = {
					nls.builtins.formatting.fish_indent,
				},
			}
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		config = function()
			require("mason").setup {
				PATH = "prepend",
				ui = {
					border = "rounded",
					icons = require("nvim-nonicons.extentions.mason").icons,
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
		end,
	},

	"b0o/schemastore.nvim",
}
