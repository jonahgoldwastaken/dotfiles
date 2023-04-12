return {
    {
        "folke/persistence.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help" } },
        keys = {
            { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
            {
                "<leader>ql",
                function() require("persistence").load { last = true } end,
                desc = "Restore Last Session",
            },
            {
                "<leader>qd",
                function() require("persistence").stop() end,
                desc = "Don't Save Current Session",
            },
        },
    },

    {
        "ojroques/nvim-osc52",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local function copy()
                if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
                    require("osc52").copy_register "+"
                end
            end

            vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
        end,
    },

    "nvim-lua/plenary.nvim",

    "MunifTanjim/nui.nvim",
}
