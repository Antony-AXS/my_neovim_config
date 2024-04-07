return {
	"lukas-reineke/indent-blankline.nvim",
	lazy = true,
	main = "ibl",
	event = "VeryLazy",
	opts = {},
	config = function()
		require("ibl").setup({
			-- indent = { highlight = highlight },
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		})
	end,
}
