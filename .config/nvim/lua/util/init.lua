local M = {}

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

function M.set_color_scheme()
	local dark_mode = vim.fn.system "defaults read -g AppleInterfaceStyle 2>/dev/null"
	if dark_mode:find "Dark" then
		vim.opt.background = "dark"
		vim.cmd "colorscheme github_dark_high_contrast"
	else
		vim.opt.background = "light"
		vim.cmd "colorscheme github_light_high_contrast"
	end
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
	return path ~= nil and path:find "work" == nil
end

function M.setup()
	vim.api.nvim_create_user_command("AutoDarkMode", M.set_color_scheme, { nargs = 0 })
end

return M
