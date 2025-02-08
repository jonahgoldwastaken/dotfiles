local util = require "jonahgold.util"
local icons = require "jonahgold.util.icons"
local settings = require "jonahgold.config.settings"

local function format()
	if settings.autoformat then require("conform").format { timeout = 250 } end
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
		commit = "124be12d782d656b3c75b513a44d9e4728406078",
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
					ui = { check_outdated_servers_on_open = true },
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
					"ts_ls",
					"yamlls",
					"marksman",
					"volar",
				},
				handlers = {
					function(server_name)
						if server_name ~= "jsonls" then
							lspconfig[server_name].setup {
								capabilities = capabilities,
							}
						end
					end,
					eslint = function()
						lspconfig.eslint.setup {
							capabilities = capabilities,
							settings = {
								run = "onSave",
							},
						}
					end,
					["emmet_ls"] = function()
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
					["yamlls"] = function()
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
					["lua_ls"] = function()
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
					["ts_ls"] = function()
						lspconfig.ts_ls.setup {
							capabilities = capabilities,
							init_options = {
								preferences = {
									importModuleSpecifierPreference = "non-relative",
								},
							},
						}
					end,
					["rust_analyzer"] = function()
						lspconfig.rust_analyzer.setup {
							capabilities = capabilities,
							settings = {
								["rust-analyzer"] = {
									cargo = { allFeatures = true },
									check = { command = "clippy", extraArgs = { "--no-deps" } },
								},
							},
							on_init = function(new_client, _) new_client.offset_encoding = "utf-16" end,
						}
					end,
					["gopls"] = function()
						lspconfig.gopls.setup {
							capabilities = capabilities,
							root_dir = lspconfig_util.root_pattern { "go.mod" },
						}
					end,
				},
			}

			local schemas = vim.inspect(schemas)

			capabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.jsonls.setup {
				capabilities = capabilities,
				on_new_config = function(new_config)
					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					vim.list_extend(new_config.settings.json.schemas, schemas)
				end,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas {
							extra = {
								{
									description = "Common definition schema.",
									fileMatch = {
										"*ApiObject.json",
										"*Workflow.json",
										"*Component.json",
										"*View.json",
										"*Store.json",
									},
									name = "bunq common",
									url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaCommon.json",
								},
								{
									description = "Definition file for generating bunq API Objects.",
									fileMatch = { "*ApiObject.json" },
									name = "API Object definition",
									url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaApiObject.json",
								},
								{
									description = "Definition file for generating bunq Components.",
									fileMatch = { "*Component.json", "*View.json" },
									name = "Component definition",
									url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaComponent.json",
								},
								{
									description = "Definition file for generating bunq Workflows.",
									fileMatch = { "*Workflow.json" },
									name = "Workflow definition",
									url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaWorkflow.json",
								},
								{
									description = "Definition file for generating bunq Stores.",
									fileMatch = { "*Store.json" },
									name = "Store definition",
									url = "file:///Users/jonah/work/frontend/develop/bunq/common/generator/schema/SchemaStore.json",
								},
							},
						},
						trace = { server = "verbose" },
						format = { enable = false, keepLines = false },
						validate = { enable = true },
					},
				},
			}

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
				astro = { "prettierd" },
				css = { "prettierd" },
				go = { "gofmt" },
				html = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				json = { "prettierd" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				rust = { "rustfmt" },
				svelte = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
			},
		},
	},
}
