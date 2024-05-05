return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	config = function()
		local ascii = require("ascii")
		require("dashboard").setup({
			theme = "hyper",
			week_header = {
				enable = true,
			},
			config = {
				header = ascii.header_0,
				shortcut = {
					{
						icon = "  ",
						icon_hl = "@variable",
						desc = "GitHub", --   󰊤                
						group = "Label",
						action = function()
							local file = vim.fn.expand("%:p")
							print("my file is " .. file)
							vim.cmd("split | terminal")
							local command = ':call jobsend(b:terminal_job_id, "xdg-open https://www.github.com/\\n")'
							vim.cmd(command)
						end,
						key = "d",
					},
					{
						icon = "󰊳  ",
						icon_hl = "@variable",
						desc = "Update",
						group = "@property",
						action = "Lazy update",
						key = "u",
					},
					{
						icon = "  ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
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
				mru = { limit = 5, icon = "  ", label = "files(s)", cwd_only = false }, --       
			},
		})
	end,
}
