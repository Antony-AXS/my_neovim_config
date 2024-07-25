local M = {}

M.taber = function()
	local tabs = require("harpoon").get_mark_config().marks
	local returnObj = {}
	-- local index = require("harpoon.mark")
	for k, v in pairs(tabs) do
		returnObj[k] = {
			function()
				return v["filename"]
			end,
		}
	end
	vim.print(returnObj)
	return returnObj
end

return M
