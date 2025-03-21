local M = {}

---@param client vim.lsp.Client|nil
---@param capability string
---@return boolean
function M.lsp_client_has_capability(client, capability)
	return client ~= nil and client.server_capabilities[capability .. "Provider"]
end

function M.telescope(builtin, opts)
	local params = { builtin = builtin, opts = opts }

	return function()
		builtin = params.builtin
		opts = params.opts or {}

		if builtin == "files" then
			if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
				opts.show_untracked = true
				builtin = "git_files"
			else
				builtin = "find_files"
			end
		end
		require("telescope.builtin")[builtin](opts)
	end
end

function M.in_work_dir()
	local path = vim.loop.cwd()
	return path ~= nil and path:find "work" ~= nil
end

return M
