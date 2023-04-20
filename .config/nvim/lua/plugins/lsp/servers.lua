return {
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                cargo = { allFeatures = true },
                check = { command = "clippy", extraArgs = { "--no-deps" } },
                procMacro = { enable = true },
            },
        },
    },
    astro = {},
    tsserver = {},
    eslint = {
        on_attach = function(_client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
            })
        end
    },
    svelte = {},
    volar = {
        init_options = {
            typescript = {
                tsdk = vim.fn.stdpath "data"
                    .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
            },
        },
    },
    jsonls = {
        settings = {
            json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
            },
        },
    },
    tailwindcss = {
        root_dir = require("lspconfig.util").root_pattern(
            "tailwind.config.js",
            "tailwind.config.ts",
            "tailwind.config.cjs"
        ),
    },
    lua_ls = {
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
    },
    yamlls = {
        settings = {
            yaml = {
                keyOrdering = false,
            },
        },
    },
    taplo = {},
    html = {},
    emmet_ls = {
        filetypes = {
            "html",
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "handlebars",
        },
    },
}
