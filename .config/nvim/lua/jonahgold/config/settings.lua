---@class jonahgold.settings
---@field autoformat boolean whether automatic formatting on write is enabled.
local M = {}

function M:toggle_autoformat() self.autoformat = not self.autoformat end

---@return jonahgold.settings
function M.new()
	return setmetatable({
		autoformat = true,
	}, { __index = M })
end

local Settings = M.new()

vim.api.nvim_create_user_command(
	"ToggleFormat",
	function() Settings:toggle_autoformat() end,
	{ nargs = 0, desc = "Toggle autoformatting" }
)

return Settings
