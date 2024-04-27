return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	config = function()
		local ascii = require("ascii")
		require("dashboard").setup({
			theme = "hyper",
			config = {
				header = ascii.header_2,
				packages = { enable = true }, -- show how many plugins neovim loaded
				-- limit how many projects list, action when you press key or enter it will run this action.
				-- action can be a functino type, e.g.
				-- action = function(path) vim.cmd('Telescope find_files cwd=' .. path) end,
				project = {
					enable = true,
					limit = 3,
					icon = "your icon",
					label = "",
					action = "Telescope find_files cwd=",
				},
				mru = { limit = 5, icon = "your icon", label = "", cwd_only = false },
			},
		})
	end,
}
