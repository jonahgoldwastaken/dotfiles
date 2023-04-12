local icons = require "config.icons"

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "folke/neoconf.nvim",           cmd = "Neoconf", config = true },
            { "folke/neodev.nvim",            config = true },
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
                if client.name ~= "tsserver" then require("lsp-inlayhints").on_attach(client, buffer) end
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
        "jose-elias-alvarez/null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            {
                "jay-babu/mason-null-ls.nvim",
                opts = function(_, opts)
                    local nls = require "null-ls"
                    vim.tbl_extend("force", opts or {}, {
                        automatic_installation = false,
                        ensure_installed = {
                            "prettierd",
                            "eslint_d",
                            "stylua",
                        },
                        handlers = {
                            function(source_name, methods)
                                require "mason-null-ls.automatic_setup" (source_name, methods)
                            end,
                            prettierd = function()
                                nls.register(nls.builtins.formatting.prettierd.with {
                                    extra_filetypes = {
                                        "markdown",
                                        "astro",
                                        "svelte",
                                    },
                                })
                            end,
                            eslint_d = function()
                                local o = {
                                    extra_filetypes = { "astro", "svelte" },
                                    condition = function(utils)
                                        return utils.root_has_file {
                                            ".eslintrc.json",
                                            ".eslintrc.js",
                                            ".eslintrc.cjs",
                                            ".eslintrc",
                                        }
                                    end,
                                }
                                nls.register(nls.builtins.diagnostics.eslint_d.with(o))
                                nls.register(nls.builtins.code_actions.eslint_d.with(o))
                            end,
                        },
                    })
                end,
            },
        },
        opts = function(_, opts)
            local nls = require "null-ls"

            vim.tbl_extend("force", opts or {}, {
                debounce = 150,
                save_after_format = false,
                sources = {
                    nls.builtins.formatting.fish_indent,
                    nls.builtins.code_actions.gitsigns,
                },
            })
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
