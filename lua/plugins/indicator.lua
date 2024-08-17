return {
	"Antony-AXS/indicator.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local Indicator = require("indicator")

		Indicator.setup({
			indicator_event = true,
			window_highlight_event = true,
		})

		vim.keymap.set("n", "<leader>bx", function()
			Indicator.indicateCurrent(nil, nil, true)
		end, { silent = true })
		vim.keymap.set("n", "<leader>bv", function()
			Indicator.indicateAll(true)
		end, { silent = true })
		vim.keymap.set("n", "<leader>bc", function()
			Indicator.indicateAll(false)
		end, { silent = true })

		vim.keymap.set("n", "<leader>it", Indicator.indicator_event_activate, {})
		vim.keymap.set("n", "<leader>ir", Indicator.indicator_event_diactivate, {})

		vim.keymap.set("n", "<leader>iq", Indicator.window_highlight_event_activate, {})
		vim.keymap.set("n", "<leader>iw", Indicator.window_highlight_event_diactivate, {})
	end,
}
