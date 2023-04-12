return {
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        dependencies = { { "HiPhish/nvim-ts-rainbow2" } },
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup {
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
                    "dockerfile",
                    "yaml",
                    "fish",
                    "tsx",
                    "kdl",
                },
                highlight = { enable = true },
                indent = { enable = true },
                context_commentstring = { enable = true, enable_autocmd = false },
                rainbow = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<C-s>",
                        node_decremental = "<C-bs>",
                    },
                },
            }
        end,
    },
}
