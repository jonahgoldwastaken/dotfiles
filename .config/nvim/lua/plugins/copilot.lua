return {
    {
        "zbirenbaum/copilot.lua",
        event = { "BufReadPre", "BufNewFile" },
        cond = function()
            local path = vim.loop.cwd()
            return path ~= nil and path:find("work") == nil
        end,
        config = function()
            require("copilot").setup {
                panel = { enabled = false },
                suggestion = { enabled = false },
            }
            require("copilot_cmp").setup()
        end,
    },

    {
        "jonahgoldwastaken/copilot-status.nvim",
        dependencies = { "copilot.lua" },
        event = { "BufReadPre", "BufNewFile" },
        cond = function()
            local path = vim.loop.cwd()
            return path ~= nil and path:find("work") == nil
        end,
        opts = function()
            if vim.env.TERM ~= "alacritty" then
                return {
                    icons = {
                        idle = " ",
                        error = " ",
                        offline = " ",
                        warning = " ",
                        loading = " ",
                    },
                    debug = true,
                }
            end

            return {
                debug = true,
            }
        end,
    },
}
