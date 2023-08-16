return {
    -- More and better text-object navigation
    {
        "echasnovski/mini.ai",
        keys = {
            { "a", mode = { "x", "o" } },
            { "i", mode = { "x", "o" } },
        },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            init = function()
                -- no need to load the plugin, since we only need its queries
                require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
            end,
        },
        main = "mini.ai",
        opts = function()
            local ai = require "mini.ai"
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    a = ai.gen_spec.treesitter({ a = "@attribute.outer", i = "@attribute.inner" }, {}),
                    p = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }, {}),
                },
            }
        end,
    },

    -- Show context of cursor position
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
		opts = {
            sync_install = false,
            auto_install = true,
            ensure_installed = {
                "bash",
                "scss",
                "css",
                "lua",
                "rust",
                "astro",
                "svelte",
                "vue",
                "javascript",
                "typescript",
                "json5",
                "json",
                "toml",
                "gomod",
                "go",
                "rust",
                "markdown",
                "markdown_inline",
                "vim",
                "yaml",
                "vimdoc",
                "fish",
                "tsx",
                "kdl",
                "fish",
            },
            highlight = { enable = true },
            indent = { enable = true },
            context_commentstring = { enable = true, enable_autocmd = false },
        }
    }
}
