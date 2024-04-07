return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons").get_icons()
		require("nvim-web-devicons").set_icon({
			js = {
				icon = "󰌞",
				color = "yellow",
				cterm_color = "65",
				name = "js",
			},
			cpp = {
				icon = "",
				color = "#937af5",
				cterm_color = "65",
				name = "cpp",
			},
		})
		-- require("nvim-web-devicons").get_icon_by_filetype(filetype, opts)
		-- require("nvim-web-devicons").get_icon_colors_by_filetype(filetype, opts)
		-- require("nvim-web-devicons").get_icon_color_by_filetype(filetype, opts)
		-- require("nvim-web-devicons").get_icon_cterm_color_by_filetype(filetype, opts)
	end,
}
