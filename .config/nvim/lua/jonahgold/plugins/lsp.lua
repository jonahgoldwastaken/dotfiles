local util = require "jonahgold.util"
local icons = require "jonahgold.util.icons"
local settings = require "jonahgold.config.settings"

local function format()
	if settings.autoformat then require("conform").format { timeout = 1000 } end
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = "Jonahgold",
	callback = function(e)
		local buffer = e.buf
		local client = vim.lsp.get_client_by_id(e.data.client_id)

		if client ~= nil and client.supports_method "textDocument/formatting" then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = "Jonahgold",
				buffer = buffer,
				callback = function() format() end,
			})

			vim.keymap.set("n", "<leader>cf", format, { desc = "Format Document" })
		end

		vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
		vim.keymap.set(
			"n",
			"<leader>xd",
			"<cmd>Telescope diagnostics<cr>",
			{ desc = "Telescope Diagnostics" }
		)
		vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Goto Definition" })
		vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
		vim.keymap.set("n", "gD", "<cmd>Telescope lsp_declarations<cr>", { desc = "Goto Declarations" })
		vim.keymap.set(
			"n",
			"gI",
			"<cmd>Telescope lsp_implementations<cr>",
			{ desc = "Goto Implementations" }
		)
		vim.keymap.set(
			"n",
			"gI",
			"<cmd>Telescope lsp_type_definitions<cr>",
			{ desc = "Goto Type Definitions" }
		)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

		if util.lsp_client_has_capability(client, "signatureHelp") then
			vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
		end

		if util.lsp_client_has_capability(client, "rename") then
			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
		end

		if util.lsp_client_has_capability(client, "codeAction") then
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
		end
	end,
})

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			{
				"williamboman/mason.nvim",
				cmd = "Mason",
				opts = {
					PATH = "prepend",
					ui = {
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
				},
			},
			"hrsh7th/nvim-cmp",
			"b0o/schemastore.nvim",
		},
		config = function()
			local lspconfig = require "lspconfig"
			local lspconfig_util = require "lspconfig.util"
			local mason_lspconfig = require "mason-lspconfig"
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			mason_lspconfig.setup {
				ensure_installed = {
					"astro",
					"emmet_ls",
					"eslint",
					"gopls",
					"html",
					"jsonls",
					"lua_ls",
					"svelte",
					"tailwindcss",
					"taplo",
					"tsserver",
					"yamlls",
					"marksman",
					"volar",
				},
			}

			mason_lspconfig.setup_handlers {
				function(server_name)
					lspconfig[server_name].setup {
						capabilities = capabilities,
					}
				end,
				emmet_ls = function()
					lspconfig.emmet_ls.setup {
						capabilities = capabilities,
						filetypes = {
							"html",
							"css",
							"javascriptreact",
							"typescriptreact",
							"handlebars",
						},
					}
				end,
				yamlls = function()
					lspconfig.yamlls.setup {
						capabilities = capabilities,
						settings = {
							yaml = {
								keyOrdering = false,
								customTags = { "!reference sequence" },
							},
						},
					}
				end,
				lua_ls = function()
					lspconfig.lua_ls.setup {
						capabilities = capabilities,
						single_file_support = true,
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = true,
								},
								completion = {
									workspaceWord = false,
								},
								telemetry = {
									enable = false,
								},
							},
						},
					}
				end,
				jsonls = function()
					lspconfig.jsonls.setup {
						capabilities = capabilities,
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
					}
				end,
				tsserver = function()
					lspconfig.tsserver.setup {
						capabilities = capabilities,
						init_options = {
							preferences = {
								importModuleSpecifierPreference = "non-relative",
							},
						},
					}
				end,
				rust_analyzer = function()
					lspconfig.rust_analyzer.setup {
						capabilities = capabilities,
						settings = {
							["rust-analyzer"] = {
								cargo = { allFeatures = true },
								check = { command = "clippy", extraArgs = { "--no-deps" } },
								procMacro = { enable = true },
							},
						},
						on_init = function(new_client, _) new_client.offset_encoding = "utf-16" end,
					}
				end,
				gopls = function()
					lspconfig.gopls.setup {
						capabilities = capabilities,
						root_dir = lspconfig_util.root_pattern { "go.mod" },
					}
				end,
			}

			for name, icon in pairs(icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end

			vim.diagnostic.config {
				underline = true,
				virtual_text = { spacing = 4, prefix = icons.ui.FilledCircle },
				severity_sort = true,
			}
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufNewFile", "BufReadPre" },
		opts = {
			formatters_by_ft = {
				css = { "prettierd" },
				html = { "prettierd" },
				javascriptreact = { "prettierd" },
				javascript = { "prettierd" },
				typescriptreact = { "prettierd" },
				typescript = { "prettierd" },
				json = { "prettierd" },
				markdown = { "prettierd" },

				lua = { "stylua" },
				go = { "gofmt" },
				rust = { "rustfmt" },
			},
		},
	},
}
