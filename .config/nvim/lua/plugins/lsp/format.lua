local Util = require "lazy.core.util"

local M = {
	enabled = true,
}

function M.toggle()
	if vim.b.autoformat == false then
		vim.b.autoformat = nil
		M.enabled = true
	else
		M.enabled = not M.enabled
	end

	if M.enabled then
		Util.info("Enabled format on save", { title = "Format" })
	else
		Util.warn("Disabled format on save", { title = "Format" })
	end
end

function M.format()
	local buf = vim.api.nvim_get_current_buf()
	local ft = vim.bo[buf].filetype
	local have_formatter = #require("formatter.util").get_available_formatters_for_ft(ft) > 0

	if M.enabled then
        if (have_formatter) then
            vim.cmd "Format"
        else
            vim.lsp.buf.format { bufnr = buf }
        end
	end
end

function M.on_attach(client, buf)
	if client.supports_method "textDocument/formatting" then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat." .. buf, {}),
			buffer = buf,
			callback = function() M.format() end,
		})
	end
end

return M
