local M = {}

function M.scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Octocolors Dark"
	else
		return "Octocolors Light"
	end
end

return M
