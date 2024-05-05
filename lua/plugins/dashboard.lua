return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	config = function()
		local ascii = require("ascii")
		require("dashboard").setup({
			theme = "hyper",
			week_header = {
				enable = false,
			},
			config = {
				header = ascii.header_0,
				shortcut = {
					{
						icon = "  ", --   󰊤                
						icon_hl = "@variable",
						desc = "Github",
						group = "Label",
						action = function()
							vim.cmd("split | terminal")
							local URL = "https://www.github.com/"
							local command = string.format(':call jobsend(b:terminal_job_id, "xdg-open %s\\n")', URL)
							vim.cmd(command)
						end,
						key = "G",
					},
					{
						icon = "  ",
						icon_hl = "@variable",
						desc = "Files",
						group = "@property",
						action = "Telescope find_files",
						key = "F",
					},
					{
						icon = "󰊳  ",
						icon_hl = "@variable",
						desc = "Update",
						group = "Label",
						action = "Lazy update",
						key = "U",
					},
				},
				packages = { enable = true }, -- show how many plugins neovim loaded
				-- limit how many projects list, action when you press key or enter it will run this action.
				-- action can be a functino type, e.g.
				-- action = function(path) vim.cmd('Telescope find_files cwd=' .. path) end,
				project = {
					enable = true,
					limit = 2,
					icon = "  ", --       󰝰        󰉖    󰉕  󱞞  󰉓  󱁽        󰏓
					label = "folder(s)",
					action = "Telescope find_files cwd=",
				},
				mru = { limit = 5, icon = "  ", label = "file(s)", cwd_only = false }, --       
			},
		})
	end,
}
