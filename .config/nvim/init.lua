if vim.fn.has "nvim-0.9.0" == 1 then vim.loader.enable() end

require "config.options"

if vim.fn.argc(-1) == 0 then
    vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
            require "config.autocmds"
            require "config.keymaps"
        end
    })
else
    require "config.autocmds"
    require "config.keymaps"
end

require "config.lazy"
